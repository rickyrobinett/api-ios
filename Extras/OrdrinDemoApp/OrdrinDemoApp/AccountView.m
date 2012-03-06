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

#import "AccountView.h"
#import "LoginView.h"
#import "OICore.h"

#define BUTTON_WIDTH                250
#define BUTTON_HEIGHT               30

#define LOGIN_BUTTON_FRAME          CGRectMake(35, 30, BUTTON_WIDTH, BUTTON_HEIGHT)
#define CREATE_BUTTON_FRAME         CGRectMake(35, 80, BUTTON_WIDTH, BUTTON_HEIGHT)

#define SUBVIEW_FRAME               CGRectMake(0, 160, 480, 200)

@interface AccountView (Private)
- (void)removeCreateAccountViewIfNeeded;
- (void)removeLoginViewIfNeeded;
@end

@implementation AccountView

@synthesize loginView           = __loginView;
@synthesize createAccountButton = __createAccountButton;
@synthesize loginButton         = __loginButton;

#pragma mark -
#pragma mark Initializations

- (id)init {
  self = [super init];
  if ( self ) {
    __createAccountButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    __loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [__loginButton setTitle:@"Log In to the Existing Account" forState:UIControlStateNormal];
    [__createAccountButton setTitle:@"Create New Account" forState:UIControlStateNormal];
    
    [self addSubview:__createAccountButton];
    [self addSubview:__loginButton];
  }
  
  return self;
}

#pragma mark -
#pragma mark Lifecycles

- (void)layoutSubviews {
  [super layoutSubviews];
  
  if ( !CGRectEqualToRect(LOGIN_BUTTON_FRAME, __loginButton.frame) ) {
    __loginButton.frame = LOGIN_BUTTON_FRAME;
  }
  
  if ( !CGRectEqualToRect(CREATE_BUTTON_FRAME, __createAccountButton.frame) ) {
    __createAccountButton.frame = CREATE_BUTTON_FRAME;
  }
}

#pragma mark -
#pragma mark Public

- (void)showCreateAccountView {
  [self removeLoginViewIfNeeded];
}

- (void)showLoginView {
  [self removeCreateAccountViewIfNeeded];
  
  if ( !__loginView ) {
    __loginView = [[LoginView alloc] initWithFrame:SUBVIEW_FRAME];
    [self addSubview:__loginView];
  }
  
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  __createAccountButton = nil;
  __loginButton = nil;
  [self removeLoginViewIfNeeded];
  
  [super dealloc];
}

@end

#pragma mark -
#pragma mark Private

@implementation AccountView (Private)

- (void)removeCreateAccountViewIfNeeded {
}

- (void)removeLoginViewIfNeeded {
  if ( __loginView ) {
    [__loginView removeFromSuperview];
    OI_RELEASE_SAFELY( __loginView );
  }
}

@end