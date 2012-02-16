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
 */

#import "OIUserViewController.h"
#import "OIUserLogInView.h"
#import "OINewUserView.h"
#import "OIApplicationData.h"

@implementation OIUserViewController
{
@private  
  UIButton *__buttonLogIn;
  UIButton *__buttonNewAccount;
  OIUserLogInView   *__logInView;
  OINewUserView     *__newUserView;
}

#pragma mark -
#pragma mark Lifecycle

- (void)loadView {
  [super loadView];
  
  self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
  self.view.backgroundColor = [UIColor whiteColor];
  
  OIApplicationData *appDataManager = [OIApplicationData appDataManager];
  
  if([appDataManager isUserLogged] == NO)
  {
    self.title = NSLocalizedString( @"User: Not Logged In", "" );
  }
  else
  {
    self.title = NSLocalizedString( @"User:", "" );
  }
  
  __buttonLogIn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  __buttonLogIn.frame = CGRectMake(35, 30, 250, 30);
  [__buttonLogIn setTitle:@"Log In to the Existing Account" forState:UIControlStateNormal];
  [self.view addSubview:__buttonLogIn]; 
  
  __buttonNewAccount = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  __buttonNewAccount.frame = CGRectMake(35, 80, 250, 30);
  [__buttonNewAccount setTitle:@"Create New Account" forState:UIControlStateNormal];
  [self.view addSubview:__buttonNewAccount]; 
  
  [__buttonLogIn addTarget:self action:@selector(buttonLogInPressed) forControlEvents:UIControlEventTouchUpInside]; 
  [__buttonNewAccount addTarget:self action:@selector(buttonNewAccountPressed) forControlEvents:UIControlEventTouchUpInside];
  
  
}

- (void)hideButtons:(BOOL) hide{
  __buttonLogIn.hidden = hide;
  __buttonNewAccount.hidden = hide;
}

-(void)buttonLogInPressed {
  
  if(__newUserView != nil)
    [__newUserView removeFromSuperview];
  
  CGRect  viewRect = CGRectMake(0, 200, 480, 200);
  __logInView = [[OIUserLogInView alloc] initWithFrame:viewRect];  
  
  [self.view addSubview:__logInView]; 
}


-(void)buttonNewAccountPressed {
  
  if(__logInView != nil)
    [__logInView removeFromSuperview];
  
  CGRect  viewRect = CGRectMake(0, 160, 480, 200);
  __newUserView = [[OINewUserView alloc] initWithFrame:viewRect];  
  
  [self.view addSubview:__newUserView];   
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return NO;
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY(__buttonLogIn );
  OI_RELEASE_SAFELY(__buttonNewAccount );
  OI_RELEASE_SAFELY( __logInView );
  OI_RELEASE_SAFELY( __newUserView );
  
  [super dealloc];
}
@end
