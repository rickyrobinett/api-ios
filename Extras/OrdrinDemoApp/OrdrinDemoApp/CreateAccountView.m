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

#import "CreateAccountView.h"
#import "OICore.h"

@implementation CreateAccountView

@synthesize emailField          = __emailField;
@synthesize firstNameField      = __firstNameField;
@synthesize lastNameField       = __lastNameField;
@synthesize passwordField       = __passwordField;

@synthesize createAccountButton = __createAccountButton;

#define FIELD_LEFT_PADDING        120
#define FIELD_WIDTH               165
#define FIELD_HEIGHT              30

#define FIRST_NAME_FIELD_FRAME    CGRectMake(FIELD_LEFT_PADDING, 10, FIELD_WIDTH, FIELD_HEIGHT)
#define LAST_NAME_FIELD_FRAME     CGRectMake(FIELD_LEFT_PADDING, 50, FIELD_WIDTH, FIELD_HEIGHT)
#define EMAIL_FIELD_FRAME         CGRectMake(FIELD_LEFT_PADDING, 90, FIELD_WIDTH, FIELD_HEIGHT)
#define PASSWORD_FIELD_FRAME      CGRectMake(FIELD_LEFT_PADDING, 130, FIELD_WIDTH, FIELD_HEIGHT)

#define CREATE_ACCOUNT_BUTTON     CGRectMake(35, 170, 250, FIELD_HEIGHT)

#pragma mark -
#pragma mark Initializations

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];  
  if ( self ) {
    __emailField = [[UITextField alloc] initWithFrame:CGRectZero];
    __firstNameField = [[UITextField alloc] initWithFrame:CGRectZero];
    __lastNameField = [[UITextField alloc] initWithFrame:CGRectZero];
    __passwordField = [[UITextField alloc] initWithFrame:CGRectZero];
    
    __passwordField.secureTextEntry = YES;
    
    __emailField.borderStyle = __passwordField.borderStyle = __firstNameField.borderStyle = __lastNameField.borderStyle = UITextBorderStyleRoundedRect;
    __emailField.contentVerticalAlignment = __passwordField.contentVerticalAlignment = __firstNameField.contentVerticalAlignment = __lastNameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    __createAccountButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [__createAccountButton setTitle:@"Create Account" forState:UIControlStateNormal];
    
    [self addSubview:__createAccountButton];
    [self addSubview:__emailField];
    [self addSubview:__firstNameField];
    [self addSubview:__lastNameField];
    [self addSubview:__passwordField];
  }  

  return self;
}

#pragma mark -
#pragma mark Lifecycles

- (void)layoutSubviews {
  [super layoutSubviews];
  
  if ( !CGRectEqualToRect(EMAIL_FIELD_FRAME, __emailField.frame) ) {
    __emailField.frame = EMAIL_FIELD_FRAME;
  }
  
  if ( !CGRectEqualToRect(FIRST_NAME_FIELD_FRAME, __firstNameField.frame) ) {
    __firstNameField.frame = FIRST_NAME_FIELD_FRAME;
  }
  
  if ( !CGRectEqualToRect(LAST_NAME_FIELD_FRAME, __lastNameField.frame) ) {
    __lastNameField.frame = LAST_NAME_FIELD_FRAME;
  }
  
  if ( !CGRectEqualToRect(PASSWORD_FIELD_FRAME, __passwordField.frame) ) {
    __passwordField.frame = PASSWORD_FIELD_FRAME;
  }
  
  if ( !CGRectEqualToRect(CREATE_ACCOUNT_BUTTON, __createAccountButton.frame) ) {
    __createAccountButton.frame = CREATE_ACCOUNT_BUTTON;
  }
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  __createAccountButton = nil;
  OI_RELEASE_SAFELY( __emailField );
  OI_RELEASE_SAFELY( __firstNameField );
  OI_RELEASE_SAFELY( __lastNameField );
  OI_RELEASE_SAFELY( __passwordField );
  
  [super dealloc];
}

@end
