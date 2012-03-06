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

#import "LoginView.h"
#import "OICore.h"

@implementation LoginView

@synthesize loginButton     = __loginButton;
@synthesize passwordField   = __passwordField;
@synthesize emailField      = __emailField;

#define FIELD_WIDTH               165
#define FIELD_HEIGHT              30

#define EMAIL_FIELD_FRAME         CGRectMake(120, 10, FIELD_WIDTH, FIELD_HEIGHT)
#define PASSWORD_FIELD_FRAME      CGRectMake(120, 50, FIELD_WIDTH, FIELD_HEIGHT)

#define BUTTON_FRAME              CGRectMake(35, 90, 250, 30)

#define LABEL_FONT                [UIFont systemFontOfSize:14.0]
#define LABEL_LEFT_PADDING        35
#define LABEL_WIDTH               80
#define LABEL_HEIGHT              30

#define EMAIL_LABEL               CGRectMake(LABEL_LEFT_PADDING, 10, LABEL_WIDTH, LABEL_HEIGHT)
#define PASSWORD_LABEL            CGRectMake(LABEL_LEFT_PADDING, 50, LABEL_WIDTH, LABEL_HEIGHT)

#pragma mark -
#pragma mark Initializations

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if ( self ) {
    __emailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    __passwordLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    __emailLabel.text = @"Email:";
    __passwordLabel.text = @"Password:";
    
    __emailLabel.textAlignment = __passwordLabel.textAlignment = UITextAlignmentCenter;
    __emailLabel.font = __passwordLabel.font = LABEL_FONT;
    
    __emailField = [[UITextField alloc] initWithFrame:CGRectZero];
    __passwordField = [[UITextField alloc] initWithFrame:CGRectZero];
    __passwordField.secureTextEntry = YES;
    
    __loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [__loginButton setTitle:@"Login" forState:UIControlStateNormal];
    
    __emailField.borderStyle = __passwordField.borderStyle = UITextBorderStyleRoundedRect;
    __emailField.contentVerticalAlignment = __passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    [self addSubview:__emailLabel];
    [self addSubview:__passwordLabel];
    
    [self addSubview:__loginButton];
    [self addSubview:__emailField];
    [self addSubview:__passwordField];
  }
  
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  if ( !CGRectEqualToRect(EMAIL_FIELD_FRAME, __emailField.frame) ) {
    __emailField.frame = EMAIL_FIELD_FRAME;
  }
  
  if ( !CGRectEqualToRect(PASSWORD_FIELD_FRAME, __passwordField.frame) ) {
    __passwordField.frame = PASSWORD_FIELD_FRAME;
  }
  
  if ( !CGRectEqualToRect(BUTTON_FRAME, __loginButton.frame)) {
    __loginButton.frame = BUTTON_FRAME;
  }
  
  if ( !CGRectEqualToRect(EMAIL_LABEL, __emailLabel.frame) ) {
    __emailLabel.frame = EMAIL_LABEL;
  }
  
  if ( !CGRectEqualToRect(PASSWORD_LABEL, __passwordLabel.frame) ) {
    __passwordLabel.frame = PASSWORD_LABEL;
  }  
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  __loginButton = nil;
  OI_RELEASE_SAFELY( __emailLabel );  
  OI_RELEASE_SAFELY( __passwordLabel );    
  OI_RELEASE_SAFELY( __emailField );
  OI_RELEASE_SAFELY( __passwordField );
  
  [super dealloc];
}

@end
