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

@implementation OIUserViewController
{
@private  
    UIButton *__buttonNewAccount;  
    UIButton *__buttonLogIn;
    OIUserLogInView   *__logInView;
    OINewUserView     *__newUserView;
}

#pragma mark -
#pragma mark Lifecycle

- (void)loadView {
  [super loadView];
  
  self.title = NSLocalizedString( @"User", "" );
    
  self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];

  self.view.backgroundColor = [UIColor whiteColor];
    
  __buttonNewAccount = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  __buttonNewAccount.frame = CGRectMake(35, 30, 250, 30);
  [__buttonNewAccount setTitle:@"Create New Account" forState:UIControlStateNormal];
  [self.view addSubview:__buttonNewAccount];
    
  __buttonLogIn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  __buttonLogIn.frame = CGRectMake(35, 80, 250, 30);
  [__buttonLogIn setTitle:@"Log In to the existing Account" forState:UIControlStateNormal];
  [self.view addSubview:__buttonLogIn]; 

  [__buttonNewAccount addTarget:self action:@selector(buttonNewAccountPressed) forControlEvents:UIControlEventTouchUpInside];
  [__buttonLogIn addTarget:self action:@selector(buttonLogInPressed) forControlEvents:UIControlEventTouchUpInside];  
    
}

-(void)buttonNewAccountPressed {
    
    if(__logInView != nil)
        [__logInView removeFromSuperview];
    
    CGRect  viewRect = CGRectMake(0, 160, 480, 200);
    __newUserView = [[OINewUserView alloc] initWithFrame:viewRect];  
    
    [self.view addSubview:__newUserView];   
}

-(void)buttonLogInPressed {
    
    if(__newUserView != nil)
        [__newUserView removeFromSuperview];
    
    CGRect  viewRect = CGRectMake(0, 200, 480, 200);
    __logInView = [[OIUserLogInView alloc] initWithFrame:viewRect];  

    [self.view addSubview:__logInView]; 
    
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
    OI_RELEASE_SAFELY( __buttonNewAccount );
    OI_RELEASE_SAFELY( __buttonLogIn );
    OI_RELEASE_SAFELY( __logInView );
    OI_RELEASE_SAFELY( __newUserView );
    
    [super dealloc];
}
@end
