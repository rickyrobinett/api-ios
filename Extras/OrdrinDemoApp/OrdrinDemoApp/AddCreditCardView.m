
#import "AddCreditCardView.h"
#import "OICore.h"

#define FIELD_LEFT_PADDING            120
#define FIELD_WIDTH                   165
#define FIELD_HEIGHT                  30

#define NICK_NAME_FIELD_FRAME         CGRectMake(FIELD_LEFT_PADDING, 10, FIELD_WIDTH, FIELD_HEIGHT)
#define NAME_FIELD_FRAME              CGRectMake(FIELD_LEFT_PADDING, 50, FIELD_WIDTH, FIELD_HEIGHT)
#define CC_LAST_FIVE_FIELD_FRAME      CGRectMake(FIELD_LEFT_PADDING, 90, FIELD_WIDTH, FIELD_HEIGHT)
#define EXPIRY_MONTH_FIELD_FRAME      CGRectMake(FIELD_LEFT_PADDING, 130, FIELD_WIDTH, FIELD_HEIGHT)
#define EXPIRY_YEAR_FIELD_FRAME       CGRectMake(FIELD_LEFT_PADDING, 170, FIELD_WIDTH, FIELD_HEIGHT)
#define TYPE_FIELD_FRAME              CGRectMake(FIELD_LEFT_PADDING, 210, FIELD_WIDTH, FIELD_HEIGHT)

#define ADDRESS1_FIELD_FRAME          CGRectMake(FIELD_LEFT_PADDING, 250, FIELD_WIDTH, FIELD_HEIGHT)
#define ADDRESS2_FIELD_FRAME          CGRectMake(FIELD_LEFT_PADDING, 290, FIELD_WIDTH, FIELD_HEIGHT)
#define CITY_FIELD_FRAME              CGRectMake(FIELD_LEFT_PADDING, 330, FIELD_WIDTH, FIELD_HEIGHT)
#define STATE_FIELD_FRAME             CGRectMake(FIELD_LEFT_PADDING, 370, FIELD_WIDTH, FIELD_HEIGHT)
#define ZIP_FIELD_FRAME               CGRectMake(FIELD_LEFT_PADDING, 410, FIELD_WIDTH, FIELD_HEIGHT)

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

#pragma mark -
#pragma mark Initializations

- (id)init {
  self = [super init];
  if ( self ) {
//    self.contentSize = CGSizeMake(320, 500);
    
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
  
  [super dealloc];  
}

@end
