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

#import "ChangePasswordView.h"
#import "OICore.h"

#define FIELD_LEFT_PADDING        77
#define FIELD_WIDTH               165
#define FIELD_HEIGHT              30

#define PASSWORD_FIELD_FRAME      CGRectMake (FIELD_LEFT_PADDING, 10, FIELD_WIDTH, FIELD_HEIGHT)
#define OLD_PASSWORD_FIELD_FRAME  CGRectMake (FIELD_LEFT_PADDING, 50, FIELD_WIDTH, FIELD_HEIGHT)
#define EMAIL_FIELD_FRAME         CGRectMake (FIELD_LEFT_PADDING, 90, FIELD_WIDTH, FIELD_HEIGHT)

#define PASSWORD_LABEL_FRAME      CGRectMake (LABEL_LEFT_PADDING, 10, LABEL_WIDTH, LABEL_HEIGHT)
#define OLD_PASSWORD_LABEL_FRAME  CGRectMake (LABEL_LEFT_PADDING, 50, LABEL_WIDTH, LABEL_HEIGHT)
#define EMAIL_LABEL_FRAME         CGRectMake (LABEL_LEFT_PADDING, 90, LABEL_WIDTH, LABEL_HEIGHT)

#define BUTTON_FRAME              CGRectMake (10, 150, 300, 30)

@implementation ChangePasswordView

@synthesize passwordField    = __passwordField;
@synthesize oldPasswordField = __oldPasswordField;
@synthesize emailField       = __emailField;

@synthesize confirmButton    = __confirmButton;

#pragma mark -
#pragma mark Initializations

- (id)init {
  self = [super init];
  if ( self ) {    
    __passwordField = [[UITextField alloc] initWithFrame:CGRectZero];
    __oldPasswordField = [[UITextField alloc] initWithFrame:CGRectZero];
    __emailField = [[UITextField alloc] initWithFrame:CGRectZero];
    
    __passwordField.placeholder = @"New password";
    __oldPasswordField.placeholder = @"Old password";
    __emailField.placeholder = @"E-mail";
    
    __passwordField.secureTextEntry = __oldPasswordField.secureTextEntry = YES;
    __passwordField.borderStyle = __oldPasswordField.borderStyle = __emailField.borderStyle = UITextBorderStyleRoundedRect;
    
    __confirmButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [__confirmButton setTitle:@"Confirm" forState:UIControlStateNormal];
    
    [self addSubview:__confirmButton];
        
    [self addSubview:__passwordField];
    [self addSubview:__oldPasswordField];
    [self addSubview:__emailField];    
  }
  
  return self;
}

#pragma mark -
#pragma mark Lifecycles

- (void)layoutSubviews {
  [super layoutSubviews];
  
  if ( !CGRectEqualToRect(EMAIL_FIELD_FRAME, __emailField.frame)) {
    __emailField.frame = EMAIL_FIELD_FRAME;
  }
  
  if ( !CGRectEqualToRect(PASSWORD_FIELD_FRAME, __passwordField.frame)) {
    __passwordField.frame = PASSWORD_FIELD_FRAME;
  }
  
  if ( !CGRectEqualToRect(OLD_PASSWORD_FIELD_FRAME, __oldPasswordField.frame)) {
    __oldPasswordField.frame = OLD_PASSWORD_FIELD_FRAME;
  }
    
  if ( !CGRectEqualToRect(BUTTON_FRAME, __confirmButton.frame) ) {
    __confirmButton.frame = BUTTON_FRAME;
  }
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  __confirmButton = nil;
  OI_RELEASE_SAFELY( __passwordField );
  OI_RELEASE_SAFELY( __oldPasswordField );
  OI_RELEASE_SAFELY( __emailField );
    
  [super dealloc];  
}

@end
