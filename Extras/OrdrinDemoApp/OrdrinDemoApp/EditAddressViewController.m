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

#import "EditAddressViewController.h"
#import "OIAddress.h"
#import "EditAddressView.h"
#import "OICore.h"
#import "UserAddressesViewController.h"
#import "UserAddressesDataSource.h"
#import "UserAddressesModel.h"

@interface EditAddressViewController (Private)
- (void)hideKeyboard;
- (void)updateAddressButtonDidPress;
@end

@implementation EditAddressViewController

@synthesize delegate = __delegate;

#pragma mark -
#pragma mark Initializations

- (id)initWithAddress:(OIAddress *)address {
  self = [super init];
  if ( self ) {
    __editAddress = [address retain];
    self.title = @"Update address";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(updateAddressButtonDidPress)];    
  }
  
  return self;
}

#pragma mark -
#pragma mark Lifecycle

- (void)loadView {
  [super loadView];
  
  __editAddressView = [[EditAddressView alloc] initWithAddress:__editAddress];
  __editAddressView.phoneField.delegate = self;
  
  self.view = __editAddressView;  
}

- (void)viewDidUnload {
  [super viewDidUnload];
  
  [self releaseWithDealloc:NO];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  CGFloat originY = textField.frame.origin.y + textField.frame.size.height;
  if ( originY > 185 ) {
    CGRect frame = __editAddressView.frame;
    frame.origin.y = 185 - originY;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:1.0];
    __editAddressView.frame = frame;
    [UIView commitAnimations];
  }
}

#pragma mark -
#pragma mark Events

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [self hideKeyboard];
  
  if ( __editAddressView.frame.origin.y != 0 ) {
    CGRect frame = __editAddressView.frame;
    frame.origin.y = 0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:1.0];
    __editAddressView.frame = frame;
    [UIView commitAnimations];
  }
  
}

#pragma mark -
#pragma mark Memory management

- (void)releaseWithDealloc:(BOOL)dealloc {
  OI_RELEASE_SAFELY( __editAddressView );
  if ( dealloc ) {
    OI_RELEASE_SAFELY( __editAddress );
    __delegate = nil;
  }  
}

- (void)dealloc {
  [self releaseWithDealloc:YES];
  [super dealloc];
}

@end

#pragma mark -
#pragma mark Private

@implementation EditAddressViewController (Private)

- (void)hideKeyboard {
  [__editAddressView.nickNameField resignFirstResponder];
  [__editAddressView.stateField resignFirstResponder];
  [__editAddressView.zipField resignFirstResponder];
  [__editAddressView.cityField resignFirstResponder];
  [__editAddressView.addr1Field resignFirstResponder];
  [__editAddressView.addr2Field resignFirstResponder];
  [__editAddressView.phoneField resignFirstResponder];  
}

- (void)updateAddressButtonDidPress {
  NSString *street = __editAddressView.addr1Field.text;
  NSString *city = __editAddressView.cityField.text;
  NSString *postalCodeStr = __editAddressView.zipField.text;
  NSString *nickName = __editAddressView.nickNameField.text;
  NSString *state = __editAddressView.stateField.text;
  NSString *address2 = __editAddressView.addr2Field.text;
  NSString *phoneNumber = __editAddressView.phoneField.text;
  
  if ( !street || !city || !postalCodeStr || !nickName || !state || !address2 || !phoneNumber ) {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please fill all fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    OI_RELEASE_SAFELY( alertView );
    
    return;    
  }
  
  NSNumber *postalCode = [NSNumber numberWithInt: postalCodeStr.intValue];    
  OIAddress *address = [OIAddress addressWithStreet:street city:city postalCode:postalCode];
  
  address.nickname = nickName;
  address.state = state;
  address.address2 = address2;
  address.phoneNumber = phoneNumber;
    
  [__editAddress updateAddressWithAddress:address usingBlock:^void( NSError *error ) {
    if ( error ) {
      UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:error.domain delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
      [alertView show];
      OI_RELEASE_SAFELY( alertView );
    }
    UserAddressesViewController *viewController = (UserAddressesViewController *)__delegate;
    [viewController.userAddressesDataSource.model reload];
    [self.navigationController popViewControllerAnimated:YES];    
  }];
  
}

@end
