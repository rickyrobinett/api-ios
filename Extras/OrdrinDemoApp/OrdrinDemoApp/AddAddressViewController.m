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

#import "AddAddressViewController.h"
#import "OICore.h"
#import "AddAddressView.h"
#import "OIAddress.h"
#import "UserAddressesViewController.h"
#import "UserAddressesModel.h"
#import "UserAddressesDataSource.h"

@interface AddAddressViewController (Private)
- (void)hideKeyboard;
- (void)createAddressButtonDidPress;
@end

@implementation AddAddressViewController

@synthesize delegate = __delegate;

#pragma mark -
#pragma mark Initializations

- (id)init {
  self = [super init];
  if ( self ) {
    self.title = @"Add address";
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(createAddressButtonDidPress)];
    self.navigationItem.rightBarButtonItem = buttonItem;
    OI_RELEASE_SAFELY( buttonItem );
  }
  
  return self;
}

#pragma mark -
#pragma mark Lifecycle

- (void)loadView {
  [super loadView];

  __addAddressView = [[AddAddressView alloc] init];
  __addAddressView.phoneField.delegate = self;
  self.view = __addAddressView;
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
    CGRect frame = __addAddressView.frame;
    frame.origin.y = 185 - originY;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:1.0];
    __addAddressView.frame = frame;
    [UIView commitAnimations];
  }
}

#pragma mark -
#pragma mark Events

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [self hideKeyboard];
  
  if ( __addAddressView.frame.origin.y != 0 ) {
    CGRect frame = __addAddressView.frame;
    frame.origin.y = 0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:1.0];
    __addAddressView.frame = frame;
    [UIView commitAnimations];
  }
  
}

#pragma mark -
#pragma mark Memory management

- (void)releaseWithDealloc:(BOOL)dealloc {
  OI_RELEASE_SAFELY( __addAddressView );
  if ( dealloc ) {
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

@implementation AddAddressViewController (Private)

- (void)hideKeyboard {
  [__addAddressView.nickNameField resignFirstResponder];
  [__addAddressView.stateField resignFirstResponder];
  [__addAddressView.zipField resignFirstResponder];
  [__addAddressView.cityField resignFirstResponder];
  [__addAddressView.addr1Field resignFirstResponder];
  [__addAddressView.addr2Field resignFirstResponder];
  [__addAddressView.phoneField resignFirstResponder];  
}

- (void)createAddressButtonDidPress {
  NSString *street = __addAddressView.addr1Field.text;
  NSString *city = __addAddressView.cityField.text;
  NSString *postalCodeStr = __addAddressView.zipField.text;
  NSString *nickName = __addAddressView.nickNameField.text;
  NSString *state = __addAddressView.stateField.text;
  NSString *address2 = __addAddressView.addr2Field.text;
  NSString *phoneNumber = __addAddressView.phoneField.text;
  
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
  
  [OIAddress addAddress:address usingBlock:^void( NSError *error ) {
    if ( error ) {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.domain delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
      [alert show];
      OI_RELEASE_SAFELY( alert );
    } else {
      UserAddressesViewController *viewController = (UserAddressesViewController *)__delegate;
      [viewController.userAddressesDataSource.model reload];
      [self.navigationController popViewControllerAnimated:YES];
    }    
  }];
}

@end
