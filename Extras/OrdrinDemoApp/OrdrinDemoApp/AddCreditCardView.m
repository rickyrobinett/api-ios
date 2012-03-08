
#import "AddCreditCardView.h"
#import "OICore.h"

#define FIELD_LEFT_PADDING            120
#define FIELD_WIDTH                   165
#define FIELD_HEIGHT                  25

#define NICK_NAME_FIELD_FRAME         CGRectMake(FIELD_LEFT_PADDING, 10, FIELD_WIDTH, FIELD_HEIGHT)
#define NAME_FIELD_FRAME              CGRectMake(FIELD_LEFT_PADDING, 45, FIELD_WIDTH, FIELD_HEIGHT)
#define CC_LAST_FIVE_FIELD_FRAME      CGRectMake(FIELD_LEFT_PADDING, 80, FIELD_WIDTH, FIELD_HEIGHT)
#define EXPIRY_MONTH_FIELD_FRAME      CGRectMake(FIELD_LEFT_PADDING, 115, FIELD_WIDTH, FIELD_HEIGHT)
#define EXPIRY_YEAR_FIELD_FRAME       CGRectMake(FIELD_LEFT_PADDING, 150, FIELD_WIDTH, FIELD_HEIGHT)
#define TYPE_FIELD_FRAME              CGRectMake(FIELD_LEFT_PADDING, 185, FIELD_WIDTH, FIELD_HEIGHT)

#define ADDRESS1_FIELD_FRAME          CGRectMake(FIELD_LEFT_PADDING, 220, FIELD_WIDTH, FIELD_HEIGHT)
#define ADDRESS2_FIELD_FRAME          CGRectMake(FIELD_LEFT_PADDING, 255, FIELD_WIDTH, FIELD_HEIGHT)
#define CITY_FIELD_FRAME              CGRectMake(FIELD_LEFT_PADDING, 290, FIELD_WIDTH, FIELD_HEIGHT)
#define STATE_FIELD_FRAME             CGRectMake(FIELD_LEFT_PADDING, 325, FIELD_WIDTH, FIELD_HEIGHT)
#define ZIP_FIELD_FRAME               CGRectMake(FIELD_LEFT_PADDING, 360, FIELD_WIDTH, FIELD_HEIGHT)


#define LABEL_FONT                    [UIFont fontWithName:@"Helvetica" size:12]

#define LABEL_LEFT_PADDING            35
#define LABEL_WIDTH                   80
#define LABEL_HEIGHT                  25

#define NICK_NAME_LABEL_FRAME         CGRectMake(LABEL_LEFT_PADDING, 10, LABEL_WIDTH, LABEL_HEIGHT)
#define NAME_LABEL_FRAME              CGRectMake(LABEL_LEFT_PADDING, 45, LABEL_WIDTH, LABEL_HEIGHT)
#define CC_LAST_FIVE_LABEL_FRAME      CGRectMake(LABEL_LEFT_PADDING, 80, LABEL_WIDTH, LABEL_HEIGHT)
#define EXPIRY_MONTH_LABEL_FRAME      CGRectMake(LABEL_LEFT_PADDING, 115, LABEL_WIDTH, LABEL_HEIGHT)
#define EXPIRY_YEAR_LABEL_FRAME       CGRectMake(LABEL_LEFT_PADDING, 150, LABEL_WIDTH, LABEL_HEIGHT)
#define TYPE_LABEL_FRAME              CGRectMake(LABEL_LEFT_PADDING, 185, LABEL_WIDTH, LABEL_HEIGHT)

#define ADDRESS1_LABEL_FRAME          CGRectMake(LABEL_LEFT_PADDING, 220, LABEL_WIDTH, LABEL_HEIGHT)
#define ADDRESS2_LABEL_FRAME          CGRectMake(LABEL_LEFT_PADDING, 255, LABEL_WIDTH, LABEL_HEIGHT)
#define CITY_LABEL_FRAME              CGRectMake(LABEL_LEFT_PADDING, 290, LABEL_WIDTH, LABEL_HEIGHT)
#define STATE_LABEL_FRAME             CGRectMake(LABEL_LEFT_PADDING, 325, LABEL_WIDTH, LABEL_HEIGHT)
#define ZIP_LABEL_FRAME               CGRectMake(LABEL_LEFT_PADDING, 360, LABEL_WIDTH, LABEL_HEIGHT)


@implementation AddCreditCardView

@synthesize nickNameField     = __nickNameField;
@synthesize nameField         = __nameField;
@synthesize ccLastFiveField   = __ccLastFiveField;
@synthesize expiryYearField   = __expiryYearField;
@synthesize expiryMonthField  = __expiryMonthField;
@synthesize typeField         = __typeField;

@synthesize billAddr1Field    = __billAddr1Field;
@synthesize billAddr2Field    = __billAddr2Field;
@synthesize billCityField     = __billCityField;
@synthesize billStateField    = __billStateField;
@synthesize billZipField      = __billZipField;

@synthesize nickNameLabel     = __nickNameLabel;
@synthesize nameLabel         = __nameLabel;
@synthesize ccLastFiveLabel   = __ccLastFiveLabel;
@synthesize expiryYearLabel   = __expiryYearLabel;
@synthesize expiryMonthLabel  = __expiryMonthLabel;
@synthesize typeLabel         = __typeLabel;

@synthesize billAddr1Label    = __billAddr1Label;
@synthesize billAddr2Label    = __billAddr2Label;
@synthesize billCityLabel     = __billCityLabel;
@synthesize billStateLabel    = __billStateLabel;
@synthesize billZipLabel      = __billZiplabel;

#pragma mark -
#pragma mark Initializations

- (id)init {
  self = [super init];
  if ( self ) {
    __nickNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    __nickNameLabel.text = @"Nick name:";
    __nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    __nameLabel.text = @"Name:";
    __ccLastFiveLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    __ccLastFiveLabel.text = @"Last five:";
    __expiryMonthLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    __expiryMonthLabel.text = @"Expiration month:";
    __expiryYearLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    __expiryYearLabel.text = @"Expiration year:";
    __typeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    __typeLabel.text = @"Type:";
    __billAddr1Label = [[UILabel alloc] initWithFrame:CGRectZero];
    __billAddr1Label.text = @"Address:";
    __billAddr2Label = [[UILabel alloc] initWithFrame:CGRectZero];
    __billAddr2Label.text = @"Address 2:";
    __billCityLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    __billCityLabel.text = @"City:";
    __billStateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    __billStateLabel.text = @"State:";
    __billZiplabel = [[UILabel alloc] initWithFrame:CGRectZero];
    __billZiplabel.text = @"Zip code:";
    
    __nickNameLabel.font = __nameLabel.font = __ccLastFiveLabel.font = __expiryYearLabel.font = __expiryMonthLabel.font = __typeLabel.font = __billZiplabel.font = __billStateLabel.font = __billCityLabel.font = __billAddr2Label.font = __billAddr1Label.font = LABEL_FONT;
    
    __nickNameField = [[UITextField alloc] initWithFrame:CGRectZero];
    __nameField = [[UITextField alloc] initWithFrame:CGRectZero];
    __ccLastFiveField = [[UITextField alloc] initWithFrame:CGRectZero];
    __expiryMonthField = [[UITextField alloc] initWithFrame:CGRectZero];
    __expiryYearField = [[UITextField alloc] initWithFrame:CGRectZero];
    __typeField = [[UITextField alloc] initWithFrame:CGRectZero];    
    __billAddr1Field = [[UITextField alloc] initWithFrame:CGRectZero];
    __billAddr2Field = [[UITextField alloc] initWithFrame:CGRectZero];
    __billCityField = [[UITextField alloc] initWithFrame:CGRectZero];
    __billStateField = [[UITextField alloc] initWithFrame:CGRectZero];
    __billZipField = [[UITextField alloc] initWithFrame:CGRectZero];
    
    __nickNameField.borderStyle = __nameField.borderStyle = __ccLastFiveField.borderStyle = __expiryMonthField.borderStyle = __expiryYearField.borderStyle = __typeField.borderStyle = __billZipField.borderStyle = __billStateField.borderStyle = __billCityField.borderStyle = __billAddr2Field.borderStyle = __billAddr1Field.borderStyle = UITextBorderStyleRoundedRect;
    
    [self addSubview:__nickNameField];
    [self addSubview:__nameField];
    [self addSubview:__ccLastFiveField];
    [self addSubview:__expiryYearField];
    [self addSubview:__expiryMonthField];
    [self addSubview:__typeField];    
    [self addSubview:__billAddr1Field];
    [self addSubview:__billAddr2Field];
    [self addSubview:__billCityField];
    [self addSubview:__billStateField];
    [self addSubview:__billZipField];    
    
    [self addSubview:__nickNameLabel];
    [self addSubview:__nameLabel];
    [self addSubview:__ccLastFiveLabel];
    [self addSubview:__expiryYearLabel];
    [self addSubview:__expiryMonthLabel];
    [self addSubview:__typeLabel];    
    [self addSubview:__billAddr1Label];
    [self addSubview:__billAddr2Label];
    [self addSubview:__billCityLabel];
    [self addSubview:__billStateLabel];
    [self addSubview:__billZiplabel];        
  }
  
  return self;
}

#pragma mark -
#pragma mark Lifecycles

- (void)layoutSubviews {
  [super layoutSubviews];
  
  if ( !CGRectEqualToRect(NICK_NAME_FIELD_FRAME, __nickNameField.frame) ) {
    __nickNameField.frame = NICK_NAME_FIELD_FRAME;
  }
  
  if ( !CGRectEqualToRect(NAME_FIELD_FRAME, __nameField.frame) ) {
    __nameField.frame = NAME_FIELD_FRAME;
  }

  if ( !CGRectEqualToRect(CC_LAST_FIVE_FIELD_FRAME, __ccLastFiveField.frame) ) {
    __ccLastFiveField.frame = CC_LAST_FIVE_FIELD_FRAME;
  }

  if ( !CGRectEqualToRect(EXPIRY_YEAR_FIELD_FRAME, __expiryYearField.frame) ) {
    __expiryYearField.frame = EXPIRY_YEAR_FIELD_FRAME;
  }

  if ( !CGRectEqualToRect(EXPIRY_MONTH_FIELD_FRAME, __expiryMonthField.frame) ) {
    __expiryMonthField.frame = EXPIRY_MONTH_FIELD_FRAME;
  }
  
  if ( !CGRectEqualToRect(TYPE_FIELD_FRAME, __typeField.frame) ) {
    __typeField.frame = TYPE_FIELD_FRAME;
  }

  if ( !CGRectEqualToRect(ADDRESS1_FIELD_FRAME, __billAddr1Field.frame) ) {
    __billAddr1Field.frame = ADDRESS1_FIELD_FRAME;
  }

  if ( !CGRectEqualToRect(ADDRESS2_FIELD_FRAME, __billAddr2Field.frame) ) {
    __billAddr2Field.frame = ADDRESS2_FIELD_FRAME;
  }

  if ( !CGRectEqualToRect(CITY_FIELD_FRAME, __billCityField.frame) ) {
    __billCityField.frame = CITY_FIELD_FRAME;
  }

  if ( !CGRectEqualToRect(STATE_FIELD_FRAME, __billStateField.frame) ) {
    __billStateField.frame = STATE_FIELD_FRAME;
  }
  
  if ( !CGRectEqualToRect(ZIP_FIELD_FRAME, __billZipField.frame) ) {
    __billZipField.frame = ZIP_FIELD_FRAME;
  }
  
  if ( !CGRectEqualToRect(NICK_NAME_LABEL_FRAME, __nickNameLabel.frame) ) {
    __nickNameLabel.frame = NICK_NAME_LABEL_FRAME;
  }
  
  if ( !CGRectEqualToRect(NAME_LABEL_FRAME, __nameLabel.frame) ) {
    __nameLabel.frame = NAME_LABEL_FRAME;
  }
  
  if ( !CGRectEqualToRect(CC_LAST_FIVE_LABEL_FRAME, __ccLastFiveLabel.frame) ) {
    __ccLastFiveLabel.frame = CC_LAST_FIVE_LABEL_FRAME;
  }
  
  if ( !CGRectEqualToRect(EXPIRY_YEAR_LABEL_FRAME, __expiryYearLabel.frame) ) {
    __expiryYearLabel.frame = EXPIRY_YEAR_LABEL_FRAME;
  }
  
  if ( !CGRectEqualToRect(EXPIRY_MONTH_LABEL_FRAME, __expiryMonthLabel.frame) ) {
    __expiryMonthLabel.frame = EXPIRY_MONTH_LABEL_FRAME;
  }
  
  if ( !CGRectEqualToRect(TYPE_LABEL_FRAME, __typeLabel.frame) ) {
    __typeLabel.frame = TYPE_LABEL_FRAME;
  }
  
  if ( !CGRectEqualToRect(ADDRESS1_LABEL_FRAME, __billAddr1Label.frame) ) {
    __billAddr1Label.frame = ADDRESS1_LABEL_FRAME;
  }
  
  if ( !CGRectEqualToRect(ADDRESS2_LABEL_FRAME, __billAddr2Label.frame) ) {
    __billAddr2Label.frame = ADDRESS2_LABEL_FRAME;
  }
  
  if ( !CGRectEqualToRect(CITY_LABEL_FRAME, __billCityLabel.frame) ) {
    __billCityLabel.frame = CITY_LABEL_FRAME;
  }
  
  if ( !CGRectEqualToRect(STATE_LABEL_FRAME, __billStateLabel.frame) ) {
    __billStateLabel.frame = STATE_LABEL_FRAME;
  }
  
  if ( !CGRectEqualToRect(ZIP_LABEL_FRAME, __billZiplabel.frame) ) {
    __billZiplabel.frame = ZIP_LABEL_FRAME;
  }

}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  OI_RELEASE_SAFELY( __nickNameField );
  OI_RELEASE_SAFELY( __nameField );
  OI_RELEASE_SAFELY( __ccLastFiveField );
  OI_RELEASE_SAFELY( __expiryMonthField );
  OI_RELEASE_SAFELY( __expiryYearField );
  OI_RELEASE_SAFELY( __typeField );  
  OI_RELEASE_SAFELY( __billAddr1Field );
  OI_RELEASE_SAFELY( __billAddr2Field );
  OI_RELEASE_SAFELY( __billCityField );
  OI_RELEASE_SAFELY( __billStateField );
  OI_RELEASE_SAFELY( __billZipField );
  
  OI_RELEASE_SAFELY( __nickNameLabel );
  OI_RELEASE_SAFELY( __nameLabel );
  OI_RELEASE_SAFELY( __ccLastFiveLabel );
  OI_RELEASE_SAFELY( __expiryYearLabel );
  OI_RELEASE_SAFELY( __expiryMonthLabel );
  OI_RELEASE_SAFELY( __typeLabel );
  OI_RELEASE_SAFELY( __billAddr1Label );
  OI_RELEASE_SAFELY( __billAddr2Label );
  OI_RELEASE_SAFELY( __billCityLabel );
  OI_RELEASE_SAFELY( __billStateLabel );
  OI_RELEASE_SAFELY( __billZiplabel );
  
  [super dealloc];  
}

@end
