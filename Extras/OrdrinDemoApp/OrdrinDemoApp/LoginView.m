
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

#pragma mark -
#pragma mark Initializations

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if ( self ) {
    __emailField = [[UITextField alloc] initWithFrame:CGRectZero];
    __passwordField = [[UITextField alloc] initWithFrame:CGRectZero];
    __loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [__loginButton setTitle:@"Login" forState:UIControlStateNormal];
    
    __emailField.borderStyle = __passwordField.borderStyle = UITextBorderStyleRoundedRect;
    __emailField.contentVerticalAlignment = __passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
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
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  __loginButton = nil;
  OI_RELEASE_SAFELY( __emailField );
  OI_RELEASE_SAFELY( __passwordField );
  
  [super dealloc];
}

@end
