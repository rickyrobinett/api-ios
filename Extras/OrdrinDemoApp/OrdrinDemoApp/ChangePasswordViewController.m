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

#import "ChangePasswordViewController.h"
#import "ChangePasswordView.h"
#import "OICore.h"
#import "OIUser.h"
#import "OIUserInfo.h"

@interface ChangePasswordViewController (Private)
- (void)confirmationButtonDidPress;
- (void)hideKeyboard;
@end

@implementation ChangePasswordViewController

#pragma mark -
#pragma mark Initializations

- (id)init {
  self = [super init];
  if ( self ) {
    self.title = @"Change passwd";    
  }
  
  return self;
}

#pragma mark -
#pragma mark Lifecycles

- (void)loadView {
  [super loadView];
  
  __changePasswordView = [[ChangePasswordView alloc] init];
  [__changePasswordView.confirmButton addTarget:self action:@selector(confirmationButtonDidPress) forControlEvents:UIControlEventTouchDown];
  self.view = __changePasswordView;
}

- (void)viewDidUnload {
  [super viewDidUnload];
  
  [self releaseWithDealloc:NO];
}

#pragma mark -
#pragma mark Events

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [self hideKeyboard];
}

#pragma mark -
#pragma mark Memory management

- (void)releaseWithDealloc:(BOOL)dealloc {
  OI_RELEASE_SAFELY( __changePasswordView );
  if ( dealloc ) {
  }  
}

- (void)dealloc {
  [self releaseWithDealloc:YES];
  [super dealloc];  
}

@end

#pragma mark -
#pragma mark Private

@implementation ChangePasswordViewController (Private)

- (void)hideKeyboard {
  [__changePasswordView.passwordField resignFirstResponder];
  [__changePasswordView.oldPasswordField resignFirstResponder];
  [__changePasswordView.emailField resignFirstResponder];
}

- (void)confirmationButtonDidPress {
  NSString *prevPassword = __changePasswordView.oldPasswordField.text;
  NSString *newPassword = __changePasswordView.passwordField.text;
  NSString *email = __changePasswordView.emailField.text;
  
  if ( !newPassword || !prevPassword || !email ) {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please fill all fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    OI_RELEASE_SAFELY( alertView );

    return;
  }
  
  OIUserInfo *userInfo = [OIUserInfo sharedInstance];
  
  if ( ![prevPassword isEqualToString:userInfo.password] || ![email isEqualToString:userInfo.email]) {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Email or Password is wrong." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    OI_RELEASE_SAFELY( alertView );
    
    return;
  }
  
  [OIUser updatePassword:__changePasswordView.passwordField.text usingBlock:^void( NSError *error ) {
    if ( error ) {
      UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Password did not change." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
      [alertView show];
      OI_RELEASE_SAFELY( alertView );
    }
  }];  
}

@end