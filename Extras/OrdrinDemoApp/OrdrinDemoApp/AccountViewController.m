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
#import "OIUserInfo.h"
#import "OIUser.h"
#import "UserMenuViewController.h"

@interface AccountViewController (Private)
- (void)showUserMenu:(BOOL)animated;
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

- (void)viewDidUnload {
  [super viewDidUnload];
  
  [self releaseWithDealloc:NO];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];  
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  CGFloat originY = textField.frame.origin.y + textField.frame.size.height;  
}

#pragma mark -
#pragma mark Events

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [self hideKeyboard];
      
  if ( __accountView.frame.origin.y != 0 ) {  
    CGRect frame = __accountView.frame;    
    frame.origin.y = 0;    
    [UIView beginAnimations:nil context:nil];    
    [UIView setAnimationDelay:0.5];    
    __accountView.frame = frame;    
    [UIView commitAnimations];  
  }    
}

#pragma mark -
#pragma mark Memory management

- (void)releaseWithDealloc:(BOOL)dealloc {   
  OI_RELEASE_SAFELY( __accountView );
  if ( dealloc ) {
  }  
}

- (void)dealloc {
  [self releaseWithDealloc:YES];
  [super dealloc];
}

@end

#pragma mark -
#pragma mark User Actions

@implementation AccountViewController (UserAction)

- (void)showCreateAccountView {
  [__accountView showCreateAccountView];
  [__accountView.createAccountView.createAccountButton addTarget:self action:@selector(createAccountButtonDidPress) forControlEvents:UIControlEventTouchDown];
  __accountView.createAccountView.firstNameField.delegate = self;
  __accountView.createAccountView.lastNameField.delegate = self;
  __accountView.createAccountView.emailField.delegate = self;
  __accountView.createAccountView.passwordField.delegate = self;  
}

- (void)showLoginView {
  [__accountView showLoginView];
  [__accountView.loginView.loginButton addTarget:self action:@selector(loginButtonDidPress) forControlEvents:UIControlEventTouchDown];
  __accountView.loginView.emailField.delegate = self;
  __accountView.loginView.passwordField.delegate = self;
}

- (void)createAccountButtonDidPress {
  NSLog( @"createAccountButtonDidPress" );
  
  NSString *firstName = __accountView.createAccountView.firstNameField.text;
  NSString *lastName = __accountView.createAccountView.lastNameField.text;
  
  NSString *password = __accountView.createAccountView.passwordField.text;
  NSString *email = __accountView.createAccountView.emailField.text;
  
  OIUser *user = [OIUser userWithFirstName:firstName lastName:lastName];
  [OIUser createNewAccount:user email:email password:password usingBlock:^void( NSError *error ){    
    if ( error ) {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
      [alert show];
      OI_RELEASE_SAFELY( alert );      
    }
  }];
}

- (void)loginButtonDidPress {
//  NSString *email = __accountView.loginView.emailField.text;
//  NSString *password = __accountView.loginView.passwordField.text;  
  NSString *email = @"daniel@seznam.cz";
  NSString *password = @"mlok";
  OIUserInfo *userInfo = [OIUserInfo sharedInstance];  
  userInfo.email = email;
  userInfo.password = password;
  
  [OIUser accountInfo:email password:password usingBlockUser:^(OIUser *user) {
    
    userInfo.firstName = user.firstName;
    userInfo.lastName = user.lastName;
    userInfo.userLogged = YES;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"User succesfully logged in." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    OI_RELEASE_SAFELY( alert );
    [self showUserMenu:YES];
  } usingBlockError:^(NSError *error) {
    userInfo.userLogged = NO;
    if ( error ) {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
      [alert show];
      OI_RELEASE_SAFELY( alert );
    }    
  }];
  
}

@end

#pragma mark -
#pragma mark Private

@implementation AccountViewController (Private)

- (void)showUserMenu:(BOOL)animated {
  UserMenuViewController *userMenuViewController = [[UserMenuViewController alloc] init];
  [self.navigationController pushViewController:userMenuViewController animated:animated];
  OI_RELEASE_SAFELY( userMenuViewController );
}

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
