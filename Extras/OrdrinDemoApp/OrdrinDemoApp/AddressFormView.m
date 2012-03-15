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

#import "AddressFormView.h"
#import "OICore.h"

#define BACKGROUND_COLOR          [UIColor whiteColor]
#define PADDING                   50

#define LABEL_FONT                [UIFont fontWithName:@"Helvetica" size:12.0]

#define LABEL_WIDTH               40
#define LABEL_HEIGHT              30

#define FIELD_WIDTH               150
#define FIELD_HEIGHT              30

#define STREET_FIELD_FRAME        CGRectMake ( PADDING, 50, FIELD_WIDTH, FIELD_HEIGHT)
#define CITY_FIELD_FRAME          CGRectMake ( PADDING, 100, FIELD_WIDTH, FIELD_HEIGHT)
#define POSTAL_CODE_FIELD_FRAME   CGRectMake ( PADDING, 150, FIELD_WIDTH, FIELD_HEIGHT)

#define STREET_LABEL_FRAME        CGRectMake ( 5, 50, LABEL_WIDTH, LABEL_HEIGHT)
#define CITY_LABEL_FRAME          CGRectMake ( 5, 100, LABEL_WIDTH, LABEL_HEIGHT)
#define POSTAL_CODE_LABEL_FRAME   CGRectMake ( 5, 150, LABEL_WIDTH, LABEL_HEIGHT)

@interface AddressFormView (Private)
- (void)initSubviews;
@end

@implementation AddressFormView

@synthesize streetField     = __streetField;
@synthesize cityField       = __cityField;
@synthesize postalCodeField = __postalCodeField;

@synthesize findButton      = __findButton;

#pragma mark -
#pragma mark Initializations

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if ( self ) {
    [self initSubviews];
  }
  
  return self;
}

- (id)init {
  self = [super init];  
  if ( self ) {
    [self initSubviews];    
  }
  
  return self;
}

#pragma mark -
#pragma mark Lifecycles

- (void)layoutSubviews {
  [super layoutSubviews];
  
  if ( !CGRectEqualToRect( __streetField.frame, STREET_FIELD_FRAME)) {
    __streetField.frame = STREET_FIELD_FRAME;
  }
  
  if ( !CGRectEqualToRect( __cityField.frame, CITY_FIELD_FRAME)) {
    __cityField.frame = CITY_FIELD_FRAME;
  }
  
  if ( !CGRectEqualToRect( __postalCodeField.frame, POSTAL_CODE_FIELD_FRAME)) {
    __postalCodeField.frame = POSTAL_CODE_FIELD_FRAME;
  }
    
  if ( CGRectEqualToRect( __findButton.frame, CGRectZero)) {
    CGRect frame;
    frame.size.width = self.frame.size.width - 20;
    frame.size.height = 40;
    frame.origin.x = 10;
    frame.origin.y = __postalCodeField.frame.origin.y + CGRectGetHeight( __postalCodeField.frame ) + 10;
    __findButton.frame = frame;
  }  
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  __findButton = nil;
  OI_RELEASE_SAFELY( __streetField );
  OI_RELEASE_SAFELY( __cityField );
  OI_RELEASE_SAFELY( __postalCodeField );
  
  [super dealloc];
}

@end

#pragma mark -
#pragma mark Private

@implementation AddressFormView (Private)

- (void)initSubviews {
  self.backgroundColor = BACKGROUND_COLOR;
  __findButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [__findButton setTitle:@"Search" forState:UIControlStateNormal];
  __findButton.frame = CGRectZero;
  
  __streetField = [[UITextField alloc] initWithFrame:CGRectZero];
  __cityField = [[UITextField alloc] initWithFrame:CGRectZero];
  __postalCodeField = [[UITextField alloc] initWithFrame:CGRectZero];
  
  __streetField.borderStyle = __cityField.borderStyle = __postalCodeField.borderStyle = UITextBorderStyleRoundedRect;
  __streetField.contentVerticalAlignment = __cityField.contentVerticalAlignment = __postalCodeField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  __streetField.textAlignment = __cityField.textAlignment = __postalCodeField.textAlignment = UITextAlignmentCenter;
  
  __streetField.placeholder = @"Street";
  __cityField.placeholder = @"City";
  __postalCodeField.placeholder = @"Zip";
    
  [self addSubview:__findButton];
  [self addSubview:__streetField];
  [self addSubview:__cityField];
  [self addSubview:__postalCodeField];  
}

@end

