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

#import "AddAddressView.h"
#import "OICore.h"

#define FIELD_LEFT_PADDING            120
#define FIELD_WIDTH                   165
#define FIELD_HEIGHT                  25

#define NICK_NAME_FIELD_FRAME         CGRectMake(FIELD_LEFT_PADDING, 10, FIELD_WIDTH, FIELD_HEIGHT)
#define ADDRESS1_FIELD_FRAME          CGRectMake(FIELD_LEFT_PADDING, 45, FIELD_WIDTH, FIELD_HEIGHT)
#define ADDRESS2_FIELD_FRAME          CGRectMake(FIELD_LEFT_PADDING, 80, FIELD_WIDTH, FIELD_HEIGHT)
#define CITY_FIELD_FRAME              CGRectMake(FIELD_LEFT_PADDING, 115, FIELD_WIDTH, FIELD_HEIGHT)
#define STATE_FIELD_FRAME             CGRectMake(FIELD_LEFT_PADDING, 150, FIELD_WIDTH, FIELD_HEIGHT)
#define ZIP_FIELD_FRAME               CGRectMake(FIELD_LEFT_PADDING, 185, FIELD_WIDTH, FIELD_HEIGHT)
#define PHONE_FIELD_FRAME             CGRectMake(FIELD_LEFT_PADDING, 220, FIELD_WIDTH, FIELD_HEIGHT)


#define LABEL_FONT                    [UIFont fontWithName:@"Helvetica" size:12]

#define LABEL_LEFT_PADDING            35
#define LABEL_WIDTH                   80
#define LABEL_HEIGHT                  25

#define NICK_NAME_LABEL_FRAME         CGRectMake(LABEL_LEFT_PADDING, 10, LABEL_WIDTH, LABEL_HEIGHT)
#define ADDRESS1_LABEL_FRAME          CGRectMake(LABEL_LEFT_PADDING, 45, LABEL_WIDTH, LABEL_HEIGHT)
#define ADDRESS2_LABEL_FRAME          CGRectMake(LABEL_LEFT_PADDING, 80, LABEL_WIDTH, LABEL_HEIGHT)
#define CITY_LABEL_FRAME              CGRectMake(LABEL_LEFT_PADDING, 115, LABEL_WIDTH, LABEL_HEIGHT)
#define STATE_LABEL_FRAME             CGRectMake(LABEL_LEFT_PADDING, 150, LABEL_WIDTH, LABEL_HEIGHT)
#define ZIP_LABEL_FRAME               CGRectMake(LABEL_LEFT_PADDING, 185, LABEL_WIDTH, LABEL_HEIGHT)
#define PHONE_LABEL_FRAME             CGRectMake(LABEL_LEFT_PADDING, 220, LABEL_WIDTH, LABEL_HEIGHT)

@implementation AddAddressView

@synthesize nickNameField = __nickNameField;
@synthesize phoneField    = __phoneField;
@synthesize addr1Field    = __addr1Field;
@synthesize addr2Field    = __addr2Field;
@synthesize cityField     = __cityField;
@synthesize stateField    = __stateField;
@synthesize zipField      = __zipField;

@synthesize nickNameLabel = __nickNameLabel;
@synthesize phoneLabel    = __phoneLabel;
@synthesize addr1Label    = __addr1Label;
@synthesize addr2Label    = __addr2Label;
@synthesize cityLabel     = __cityLabel;
@synthesize stateLabel    = __stateLabel;
@synthesize zipLabel      = __zipLabel;

#pragma mark -
#pragma mark Initializations

- (id)init {
  self = [super init];
  if ( self ) {
    __addr1Label = [[UILabel alloc] initWithFrame:CGRectZero];
    __addr1Label.text = @"Address:";
    __addr2Label = [[UILabel alloc] initWithFrame:CGRectZero];
    __addr2Label.text = @"Address 2:";
    __cityLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    __cityLabel.text = @"City:";
    __stateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    __stateLabel.text = @"State:";
    __zipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    __zipLabel.text = @"Zip code:";
    __phoneLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    __phoneLabel.text = @"Phone:";
    __nickNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    __nickNameLabel.text = @"Nick name";
    
    __nickNameLabel.font = __phoneLabel.font = __zipLabel.font = __stateLabel.font = __cityLabel.font = __addr2Label.font = __addr1Label.font = LABEL_FONT;
    
    __phoneField = [[UITextField alloc] initWithFrame:CGRectZero];
    __nickNameField = [[UITextField alloc] initWithFrame:CGRectZero];
    __addr1Field = [[UITextField alloc] initWithFrame:CGRectZero];
    __addr2Field = [[UITextField alloc] initWithFrame:CGRectZero];
    __cityField = [[UITextField alloc] initWithFrame:CGRectZero];
    __stateField = [[UITextField alloc] initWithFrame:CGRectZero];
    __zipField = [[UITextField alloc] initWithFrame:CGRectZero];
    
    __nickNameField.borderStyle = __phoneField.borderStyle = __zipField.borderStyle = __stateField.borderStyle = __cityField.borderStyle = __addr2Field.borderStyle = __addr1Field.borderStyle = UITextBorderStyleRoundedRect;
    
    [self addSubview:__nickNameLabel];
    [self addSubview:__addr1Label];
    [self addSubview:__addr2Label];
    [self addSubview:__cityLabel];
    [self addSubview:__zipLabel];
    [self addSubview:__phoneLabel];
    [self addSubview:__stateLabel];
    
    [self addSubview:__nickNameField];    
    [self addSubview:__addr1Field];
    [self addSubview:__addr2Field];
    [self addSubview:__cityField];
    [self addSubview:__zipField];
    [self addSubview:__phoneField];
    [self addSubview:__stateField];
    
  }
  
  return self;
}

#pragma mark -
#pragma mark Lifecycles

- (void)layoutSubviews {
  [super layoutSubviews];
  
  if ( !CGRectEqualToRect(ADDRESS1_FIELD_FRAME, __addr1Field.frame) ) {
    __addr1Field.frame = ADDRESS1_FIELD_FRAME;
  }
  
  if ( !CGRectEqualToRect(ADDRESS2_FIELD_FRAME, __addr2Field.frame) ) {
    __addr2Field.frame = ADDRESS2_FIELD_FRAME;
  }
  
  if ( !CGRectEqualToRect(CITY_FIELD_FRAME, __cityField.frame) ) {
    __cityField.frame = CITY_FIELD_FRAME;
  }
  
  if ( !CGRectEqualToRect(STATE_FIELD_FRAME, __stateField.frame) ) {
    __stateField.frame = STATE_FIELD_FRAME;
  }
  
  if ( !CGRectEqualToRect(ZIP_FIELD_FRAME, __zipField.frame) ) {
    __zipField.frame = ZIP_FIELD_FRAME;
  }

  if ( !CGRectEqualToRect(PHONE_FIELD_FRAME, __phoneField.frame) ) {
    __phoneField.frame = PHONE_FIELD_FRAME;
  }  
  
  if ( !CGRectEqualToRect(PHONE_LABEL_FRAME, __phoneLabel.frame) ) {
    __phoneLabel.frame = PHONE_LABEL_FRAME;
  }
  
  if ( !CGRectEqualToRect(ADDRESS1_LABEL_FRAME, __addr1Label.frame) ) {
    __addr1Label.frame = ADDRESS1_LABEL_FRAME;
  }
  
  if ( !CGRectEqualToRect(ADDRESS2_LABEL_FRAME, __addr2Label.frame) ) {
    __addr2Label.frame = ADDRESS2_LABEL_FRAME;
  }
  
  if ( !CGRectEqualToRect(CITY_LABEL_FRAME, __cityLabel.frame) ) {
    __cityLabel.frame = CITY_LABEL_FRAME;
  }
  
  if ( !CGRectEqualToRect(STATE_LABEL_FRAME, __stateLabel.frame) ) {
    __stateLabel.frame = STATE_LABEL_FRAME;
  }
  
  if ( !CGRectEqualToRect(ZIP_LABEL_FRAME, __zipLabel.frame) ) {
    __zipLabel.frame = ZIP_LABEL_FRAME;
  }
  
  if ( !CGRectEqualToRect(NICK_NAME_FIELD_FRAME, __nickNameField.frame) ) {
    __nickNameField.frame = NICK_NAME_FIELD_FRAME;
  }

  if ( !CGRectEqualToRect(NICK_NAME_LABEL_FRAME, __nickNameLabel.frame) ) {
    __nickNameLabel.frame = NICK_NAME_LABEL_FRAME;
  }
  
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  OI_RELEASE_SAFELY( __nickNameField );
  OI_RELEASE_SAFELY( __addr1Field );
  OI_RELEASE_SAFELY( __addr1Field );
  OI_RELEASE_SAFELY( __cityField );
  OI_RELEASE_SAFELY( __stateField );
  OI_RELEASE_SAFELY( __zipField );
  OI_RELEASE_SAFELY( __phoneField );

  OI_RELEASE_SAFELY( __nickNameLabel );  
  OI_RELEASE_SAFELY( __addr1Label );
  OI_RELEASE_SAFELY( __addr1Label );
  OI_RELEASE_SAFELY( __cityLabel );
  OI_RELEASE_SAFELY( __stateLabel );
  OI_RELEASE_SAFELY( __zipLabel );
  OI_RELEASE_SAFELY( __phoneLabel );
  
  [super dealloc];
}

@end
