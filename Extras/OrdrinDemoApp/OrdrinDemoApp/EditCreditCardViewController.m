/**
 * Copyright (c) 2012, Tapmates s.r.o. (www.tapmates.com).
 *
 * All rights reserved. This source code can be used only for purposes specified 
 * by the given license contract signed by the rightful deputy of Tapmates s.r.o. 
 * This source code can be used only by the owner of the license.
 * 
 * Any disputes arising in respect of this agreement (license) shall be brought
 * before the Municipal Court of Prague.
 *
 *  @author(s):
 *      Petr Reichl (petr@tapmates.com)
 *      Daniel Krezelok (daniel.krezelok@tapmates.com)
 */

#import "EditCreditCardViewController.h"
#import "AddCreditCardView.h"
#import "OICardInfo.h"
#import "OIAddress.h"
#import "OICore.h"

@interface EditCreditCardViewController (Private)
- (void)hideKeyboard;
- (void)reloadButtonDidPress;
@end

@implementation EditCreditCardViewController

#pragma mark -
#pragma mark Initializations

- (id)initWithCardInfo:(OICardInfo *)creditCard {
  self = [super init];
  if ( self ) {
    __creditCard = [creditCard retain];
    UIBarButtonItem *updateButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadButtonDidPress)];
    self.navigationItem.rightBarButtonItem = updateButton;
    
    OI_RELEASE_SAFELY( updateButton );
  }
  
  return self;
}

#pragma mark -
#pragma mark Lifecycles

- (void)loadView {
  [super loadView];
  
  __creditCardView = [[AddCreditCardView alloc] init];
  __creditCardView.nickNameField.enabled = NO;
  
  __creditCardView.nickNameField.text = __creditCard.nickname;
  __creditCardView.nameField.text = __creditCard.name;
  __creditCardView.numberField.text = __creditCard.number;
  __creditCardView.cvcField.text = [NSString stringWithFormat:@"%@", __creditCard.cvc];
  __creditCardView.expiryMonthField.text = __creditCard.expirationMonth;
  __creditCardView.expiryYearField.text = __creditCard.expirationYear;
  __creditCardView.billAddr1Field.text = __creditCard.address.address1;
  __creditCardView.billAddr2Field.text = __creditCard.address.address2;
  __creditCardView.billZipField.text = [NSString stringWithFormat:@"%@",__creditCard.address.postalCode];
  __creditCardView.billStateField.text = __creditCard.address.state;
  __creditCardView.phoneField.text = __creditCard.address.phoneNumber;

  self.view = __creditCardView;
}

- (void)viewDidUnload {
  [super viewDidUnload];
  
  [self releaseWithDealloc:NO];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  CGFloat originY = textField.frame.origin.y + textField.frame.size.height;
  if ( originY > 160 ) {
    CGRect frame = __creditCardView.frame;
    frame.origin.y = 160 - originY;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:1.0];
    __creditCardView.frame = frame;
    [UIView commitAnimations];
  }
}

#pragma mark -
#pragma mark Events

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [self hideKeyboard];
  
  if ( __creditCardView.frame.origin.y != 0 ) {
    CGRect frame = __creditCardView.frame;
    frame.origin.y = 0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:1.0];
    __creditCardView.frame = frame;
    [UIView commitAnimations];
    
  }    
}

#pragma mark -
#pragma mark Memory management

- (void)releaseWithDealloc:(BOOL)dealloc {
  OI_RELEASE_SAFELY( __creditCardView );
  if ( dealloc ) {
    OI_RELEASE_SAFELY( __creditCard );    
  }  
}

- (void)dealloc {
  [self releaseWithDealloc:YES];
  [super dealloc];  
}

@end

#pragma mark -
#pragma mark Private

@implementation EditCreditCardViewController (Private)

- (void)hideKeyboard {
  [__creditCardView.nickNameField resignFirstResponder];
  [__creditCardView.nameField resignFirstResponder];
  [__creditCardView.cvcField resignFirstResponder];
  [__creditCardView.expiryMonthField resignFirstResponder];
  [__creditCardView.expiryYearField resignFirstResponder];
  [__creditCardView.numberField resignFirstResponder];
  [__creditCardView.billZipField resignFirstResponder];
  [__creditCardView.billStateField resignFirstResponder];
  [__creditCardView.billStateField resignFirstResponder];
  [__creditCardView.billCityField resignFirstResponder];
  [__creditCardView.billAddr2Field resignFirstResponder];
  [__creditCardView.billAddr1Field resignFirstResponder];
}

- (void)reloadButtonDidPress {
  NSString *nickName = __creditCardView.nickNameField.text;
  NSString *name = __creditCardView.nameField.text;
  NSString *number = __creditCardView.numberField.text;
  NSString *cvc = __creditCardView.cvcField.text;
  NSString *expiryYear = __creditCardView.expiryYearField.text;
  NSString *expiryMonth = __creditCardView.expiryMonthField.text;
  
  NSString *postalCodeStr = __creditCardView.billZipField.text;  
  NSString *street = __creditCardView.billAddr1Field.text;
  NSString *city = __creditCardView.billCityField.text;
  NSString *address2 = __creditCardView.billAddr2Field.text;
  NSString *state = __creditCardView.billStateField.text;
  NSString *phoneNumber = __creditCardView.phoneField.text;
  
  if ( !nickName || !name || !number || !cvc || !expiryMonth || !expiryYear || !postalCodeStr || !street || !city || !address2 || !state || !phoneNumber ) {    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please fill all fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    OI_RELEASE_SAFELY( alertView );
    
    return;
  }
  
  OICardInfo *cardInfo = [[[OICardInfo alloc] init] autorelease];    
  cardInfo.nickname = nickName;
  cardInfo.name = name;
  cardInfo.number = number;
  cardInfo.cvc = [NSNumber numberWithInteger:cvc.integerValue];
  cardInfo.expirationYear = expiryYear;
  cardInfo.expirationMonth = expiryMonth;
  
  NSNumber *postalCode = [NSNumber numberWithInt:postalCodeStr.intValue];
  OIAddress *address = [OIAddress addressWithStreet:street city:city postalCode:postalCode];
  address.address2 = address2;
  address.state = state;
  address.phoneNumber = phoneNumber;
  cardInfo.address = address;
  
  [__creditCard updateCreditCardWithCard:cardInfo usingBlock:^void( NSError *error ) {
    if ( error ) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error with adding credit card." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        OI_RELEASE_SAFELY( alertView );
        return;      
    } else {
      [self.navigationController popViewControllerAnimated:YES];
    }        
  }];
}

@end
