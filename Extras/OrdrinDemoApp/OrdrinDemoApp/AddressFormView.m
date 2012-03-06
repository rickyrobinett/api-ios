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

#define PADDING                   50

#define LABEL_FONT                [UIFont fontWithName:@"Helvetica" size:12.0]

#define LABEL_WIDTH               40
#define LABEL_HEIGHT              20

#define FIELD_WIDTH               150
#define FIELD_HEIGHT              30

#define STREET_FIELD_FRAME        CGRectMake ( PADDING, 50, FIELD_WIDTH, FIELD_HEIGHT)
#define CITY_FIELD_FRAME          CGRectMake ( PADDING, 100, FIELD_WIDTH, FIELD_HEIGHT)
#define POSTAL_CODE_FIELD_FRAME   CGRectMake ( PADDING, 150, FIELD_WIDTH, FIELD_HEIGHT)

#define STREET_LABEL_FRAME        CGRectMake ( 5, 55, LABEL_WIDTH, LABEL_HEIGHT)
#define CITY_LABEL_FRAME          CGRectMake ( 5, 110, LABEL_WIDTH, LABEL_HEIGHT)
#define POSTAL_CODE_LABEL_FRAME   CGRectMake ( 5, 165, LABEL_WIDTH, LABEL_HEIGHT)

#define FIND_BUTTON_FRAME         CGRectMake ( 200, 250, 60, 40)
@implementation AddressFormView

@synthesize streetField     = __streetField;
@synthesize cityField       = __cityField;
@synthesize postalCodeField = __postalCodeField;

@synthesize streetLabel     = __streetLabel;
@synthesize cityLabel       = __cityLabel;
@synthesize postalCodeLabel = __postalCodeLabel;

@synthesize findButton      = __findButton;

#pragma mark -
#pragma mark Initializations

- (id)init {
  self = [super init];  
  if ( self ) {
    
    __findButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    __streetField = [[UITextField alloc] initWithFrame:CGRectZero];
    __cityField = [[UITextField alloc] initWithFrame:CGRectZero];
    __postalCodeField = [[UITextField alloc] initWithFrame:CGRectZero];
    
    __streetField.borderStyle = __cityField.borderStyle = __postalCodeField.borderStyle = UITextBorderStyleRoundedRect;
    
    __streetLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    __cityLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    __postalCodeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    __streetLabel.font = __cityLabel.font = __postalCodeLabel.font = LABEL_FONT;
    
    __streetLabel.text = @"Street";
    __cityLabel.text = @"City";
    __postalCodeLabel.text = @"Zip";
    
    [self addSubview:__findButton];
    [self addSubview:__streetLabel];
    [self addSubview:__cityLabel];
    [self addSubview:__postalCodeLabel];
    
    [self addSubview:__streetField];
    [self addSubview:__cityField];
    [self addSubview:__postalCodeField];
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
    
  if ( !CGRectEqualToRect( __streetLabel.frame, STREET_LABEL_FRAME)) {
    __streetLabel.frame = STREET_LABEL_FRAME;
  }
  
  if ( !CGRectEqualToRect( __cityLabel.frame, CITY_LABEL_FRAME)) {
    __cityLabel.frame = CITY_LABEL_FRAME;
  }
  
  if ( !CGRectEqualToRect( __postalCodeLabel.frame, POSTAL_CODE_LABEL_FRAME)) {
    __postalCodeLabel.frame = POSTAL_CODE_LABEL_FRAME;
  }

  if ( !CGRectEqualToRect( __findButton.frame, FIND_BUTTON_FRAME)) {
    __findButton.frame = FIND_BUTTON_FRAME;
  }  
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  __findButton = nil;
  OI_RELEASE_SAFELY( __streetField );
  OI_RELEASE_SAFELY( __cityField );
  OI_RELEASE_SAFELY( __postalCodeField );
  OI_RELEASE_SAFELY( __postalCodeLabel );
  OI_RELEASE_SAFELY( __cityLabel );
  OI_RELEASE_SAFELY( __streetLabel );  
  
  [super dealloc];
}

@end
