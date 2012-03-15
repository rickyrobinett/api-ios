
#import "UserMenuView.h"

#define BUTTON_LEFT_PADDING             35
#define BUTTON_WIDTH                    250
#define BUTTON_HEIGHT                   30

#define ACCOUNT_BUTTON_FRAME            CGRectMake(BUTTON_LEFT_PADDING, 30, BUTTON_WIDTH, BUTTON_HEIGHT)
#define ADDRESS_BUTTON_FRAME            CGRectMake(BUTTON_LEFT_PADDING, 70, BUTTON_WIDTH, BUTTON_HEIGHT)
#define CREDIT_CARS_BUTTON_FRAME        CGRectMake(BUTTON_LEFT_PADDING, 110, BUTTON_WIDTH, BUTTON_HEIGHT)
#define ORDERS_HISTORY_BUTTON_FRAME     CGRectMake(BUTTON_LEFT_PADDING, 150, BUTTON_WIDTH, BUTTON_HEIGHT)
#define PASSWORD_BUTTON_FRAME           CGRectMake(BUTTON_LEFT_PADDING, 190, BUTTON_WIDTH, BUTTON_HEIGHT)
#define LOGOUT_BUTTON_FRAME             CGRectMake(BUTTON_LEFT_PADDING, 230, BUTTON_WIDTH, BUTTON_HEIGHT)

@implementation UserMenuView

@synthesize accountInfoButton   = __accountInfoButton;
@synthesize addressButton       = __addressButton;
@synthesize creditCardsButton   = __creditCardsButton;
@synthesize ordersHistoryButton = __ordersHistoryButton;
@synthesize passwordButton      = __passwordButton;
@synthesize logoutButton        = __logoutButton;

#pragma mark -
#pragma mark Initializations

- (id)init {
  self = [super init];
  if ( self ) {
    __accountInfoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    __addressButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    __creditCardsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    __ordersHistoryButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    __passwordButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    __logoutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [__accountInfoButton setTitle:@"Account Info" forState:UIControlStateNormal];
    [__addressButton setTitle:@"Addresses" forState:UIControlStateNormal];
    [__creditCardsButton setTitle:@"Credit Cards" forState:UIControlStateNormal];
    [__ordersHistoryButton setTitle:@"Orders" forState:UIControlStateNormal];
    [__passwordButton setTitle:@"Password" forState:UIControlStateNormal];
    [__logoutButton setTitle:@"Log Out" forState:UIControlStateNormal];
    
    [self addSubview:__accountInfoButton];
    [self addSubview:__addressButton];
    [self addSubview:__creditCardsButton];
    [self addSubview:__ordersHistoryButton];
    [self addSubview:__passwordButton];
    [self addSubview:__logoutButton];
  }
  
  return self;
}

#pragma mark -
#pragma mark Lifecycles

- (void)layoutSubviews {
  [super layoutSubviews];
  
  if ( !CGRectEqualToRect(ACCOUNT_BUTTON_FRAME, __accountInfoButton.frame) ) {
    __accountInfoButton.frame = ACCOUNT_BUTTON_FRAME;
  }
  
  if ( !CGRectEqualToRect(ADDRESS_BUTTON_FRAME, __addressButton.frame) ) {
    __addressButton.frame = ADDRESS_BUTTON_FRAME;
  }
  
  if ( !CGRectEqualToRect(CREDIT_CARS_BUTTON_FRAME, __creditCardsButton.frame) ) {
    __creditCardsButton.frame = CREDIT_CARS_BUTTON_FRAME;
  }
  
  if ( !CGRectEqualToRect(ORDERS_HISTORY_BUTTON_FRAME, __ordersHistoryButton.frame) ) {
    __ordersHistoryButton.frame = ORDERS_HISTORY_BUTTON_FRAME;
  }
  
  if ( !CGRectEqualToRect(PASSWORD_BUTTON_FRAME, __passwordButton.frame) ) {
    __passwordButton.frame = PASSWORD_BUTTON_FRAME;
  }
  
  if ( !CGRectEqualToRect(LOGOUT_BUTTON_FRAME, __logoutButton.frame) ) {
    __logoutButton.frame = LOGOUT_BUTTON_FRAME;
  }
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  __accountInfoButton = nil;
  __addressButton = nil;
  __creditCardsButton = nil;
  __ordersHistoryButton = nil;
  __passwordButton = nil;
  __logoutButton = nil;
  
  [super dealloc];  
}

@end
