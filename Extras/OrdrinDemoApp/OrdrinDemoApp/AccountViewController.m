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

#import "AccountViewController.h"
#import "AccountView.h"
#import "OICore.h"
#import "LoginView.h"
#import "CreateAccountView.h"

@interface AccountViewController (Private)
- (void)hideKeyboardForLoginViewIfNeeded;
- (void)hideKeyboardForCreateAccountViewIfNeeded;
- (void)hideKeyboard;
@end

@interface AccountViewController (UserAction)
- (void)createAccountButtonDidPress;
- (void)loginButtonDidPress;
- (void)showLoginView;
- (void)showCreateAccountView;
@end

@implementation AccountViewController

#pragma mark -
#pragma mark Initializations

- (id)init {
  self = [super init];
  if ( self ) {
    self.title = @"Account";
  }
  
  return self;
}

#pragma mark -
#pragma mark Lifecycles

- (void)loadView {
  [super loadView];
  
  __accountView = [[AccountView alloc] init];
  [__accountView.loginButton addTarget:self action:@selector(showLoginView) forControlEvents:UIControlEventTouchDown];
  [__accountView.createAccountButton addTarget:self action:@selector(showCreateAccountView) forControlEvents:UIControlEventTouchDown];  
  
  self.view = __accountView;
}

#pragma mark -
#pragma mark Events

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [self hideKeyboard];
}

#pragma mark -
#pragma mark Memory management

- (void)releaseWithDealloc:(BOOL)dealloc {   
  OI_RELEASE_SAFELY( __accountView );
  if ( dealloc ) {    
  }  
}

- (void)dealloc {
  [super dealloc];
}

@end

#pragma mark -
#pragma mark User Actions

@implementation AccountViewController (UserAction)

- (void)showCreateAccountView {
  [__accountView showCreateAccountView];
  [__accountView.createAccountView.createAccountButton addTarget:self action:@selector(createAccountButtonDidPress) forControlEvents:UIControlEventTouchDown];
}

- (void)showLoginView {
  [__accountView showLoginView];
  [__accountView.loginView.loginButton addTarget:self action:@selector(loginButtonDidPress) forControlEvents:UIControlEventTouchDown];  
}

- (void)createAccountButtonDidPress {
  NSLog( @"createAccountButtonDidPress" );
}

- (void)loginButtonDidPress {
  NSLog( @"loginButtonDidPress" );
}

@end

#pragma mark -
#pragma mark Private

@implementation AccountViewController (Private)

- (void)hideKeyboardForLoginViewIfNeeded {
  if ( __accountView.loginView ) {
    [__accountView.loginView.passwordField resignFirstResponder];
    [__accountView.loginView.emailField resignFirstResponder];    
  }
}

- (void)hideKeyboardForCreateAccountViewIfNeeded {
  if ( __accountView.createAccountView ) {
    [__accountView.createAccountView.firstNameField resignFirstResponder];
    [__accountView.createAccountView.lastNameField resignFirstResponder];
    [__accountView.createAccountView.emailField resignFirstResponder];
    [__accountView.createAccountView.passwordField resignFirstResponder];
  }
}

- (void)hideKeyboard {
  [self hideKeyboardForCreateAccountViewIfNeeded];
  [self hideKeyboardForLoginViewIfNeeded];
}
@end
