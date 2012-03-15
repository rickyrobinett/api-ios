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

#import "NewOrderView.h"
#import <QuartzCore/QuartzCore.h>
#import "OICore.h"

#define LEFT_PADDING                  10
#define TOP_PADDING                   10

#define BUTTON_WIDTH                  300
#define BUTTON_HEIGHT                 40

#define MENU_TABLE_WIDTH              300
#define MENU_TABLE_HEIGHT             300
#define MENU_TABLE_TOP_PADDING        (2 * TOP_PADDING) + BUTTON_HEIGHT


#define RESTAURANTS_BUTTON_FRAME      CGRectMake(LEFT_PADDING, TOP_PADDING, BUTTON_WIDTH, BUTTON_HEIGHT)

#define MENU_TABLE_FRAME              CGRectMake(LEFT_PADDING, MENU_TABLE_TOP_PADDING, MENU_TABLE_WIDTH, MENU_TABLE_HEIGHT)

#define ADDRESSES_BUTTON_TOP_PADDING  (MENU_TABLE_TOP_PADDING + MENU_TABLE_HEIGHT + TOP_PADDING)
#define ADDRESSES_BUTTON_FRAME        CGRectMake (LEFT_PADDING, ADDRESSES_BUTTON_TOP_PADDING, BUTTON_WIDTH, BUTTON_HEIGHT)


#define CARD_BUTTON_TOP_PADDING       (ADDRESSES_BUTTON_TOP_PADDING + BUTTON_HEIGHT + TOP_PADDING)
#define CARD_BUTTON_FRAME             CGRectMake(LEFT_PADDING, CARD_BUTTON_TOP_PADDING, BUTTON_WIDTH, BUTTON_HEIGHT)


#define FIELD_WIDTH                    100
#define FIELD_HEIGHT                   30
#define FIELD_TOP_PADDING              (CARD_BUTTON_TOP_PADDING + BUTTON_HEIGHT + TOP_PADDING)

#define CARD_NUMBER_FIELD_FRAME        CGRectMake(LEFT_PADDING, FIELD_TOP_PADDING, (2 * FIELD_WIDTH) - LEFT_PADDING, FIELD_HEIGHT)
#define SECURITY_CODE_FIELD_FRAME      CGRectMake (310 - FIELD_WIDTH, FIELD_TOP_PADDING, FIELD_WIDTH, FIELD_HEIGHT)

#define TIP_FIELD_TOP_PADDING          (FIELD_TOP_PADDING + FIELD_HEIGHT + TOP_PADDING)
#define TIP_FIELD_FRAME                CGRectMake(LEFT_PADDING, TIP_FIELD_TOP_PADDING, FIELD_WIDTH, FIELD_HEIGHT)

#define DATE_PICKER_WIDTH              300
#define DATE_PICKER_HEIGHT             100
#define DATE_PICKER_TOP_PADDING        (TIP_FIELD_TOP_PADDING + FIELD_HEIGHT + TOP_PADDING)

#define DATE_PICKER_FRAME              CGRectMake(LEFT_PADDING, DATE_PICKER_TOP_PADDING, DATE_PICKER_WIDTH, DATE_PICKER_HEIGHT)


@implementation NewOrderView

@synthesize creditCardButton  = __creditCardButton;
@synthesize restaurantsButton = __restaurantsButton;
@synthesize addressesButton   = __addressesButton;

@synthesize tableView         = __tableView;
@synthesize datePicker        = __datePicker;
@synthesize tipField          = __tipField;
@synthesize cardNumberField   = __cardNumberField;
@synthesize securityCodeField = __securityCodeField;

#pragma mark -
#pragma mark Initializations

- (id)init {
  self = [super init];
  if ( self ) {
    __scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    __scrollView.contentSize = CGSizeMake(320, 800);
    __scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    __restaurantsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [__restaurantsButton setTitle:@"No restaurant choosen" forState:UIControlStateNormal];
    
    __addressesButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [__addressesButton setTitle:@"No address choosen" forState:UIControlStateNormal];
    
    __creditCardButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [__creditCardButton setTitle:@"No credit card choosen" forState:UIControlStateNormal];
    
    __tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    __tableView.backgroundColor = [UIColor clearColor];
    __tableView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    __tableView.layer.borderWidth = 1.0;
    
    __datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];

    __cardNumberField = [[UITextField alloc] initWithFrame:CGRectZero];
    __securityCodeField = [[UITextField alloc] initWithFrame:CGRectZero];
    __tipField = [[UITextField alloc] initWithFrame:CGRectZero];
    
    __cardNumberField.placeholder = @"Number";
    __securityCodeField.placeholder = @"Security code";
    __tipField.placeholder = @"Tip";
    
    __cardNumberField.textAlignment = __securityCodeField.textAlignment = __tipField.textAlignment = UITextAlignmentCenter;
    __cardNumberField.contentVerticalAlignment = __securityCodeField.contentVerticalAlignment = __tipField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    __tipField.borderStyle = __cardNumberField.borderStyle = __securityCodeField.borderStyle = UITextBorderStyleRoundedRect;
        
    [__scrollView addSubview:__tipField];
    [__scrollView addSubview:__cardNumberField];
    [__scrollView addSubview:__securityCodeField];
    [__scrollView addSubview:__datePicker];
    [__scrollView addSubview:__tableView];
    [__scrollView addSubview:__creditCardButton];    
    [__scrollView addSubview:__restaurantsButton];
    [__scrollView addSubview:__addressesButton];

    [self addSubview:__scrollView];
  }
  
  return self;
}

#pragma mark -
#pragma mark Lifecycles

- (void)layoutSubviews {
  [super layoutSubviews];
  
  if ( !CGRectEqualToRect(__scrollView.frame, self.frame) ) {
    __scrollView.frame = self.frame;
  }

  if ( !CGRectEqualToRect(__tipField.frame, TIP_FIELD_FRAME) ) {
    __tipField.frame = TIP_FIELD_FRAME;
  }
  
  if ( !CGRectEqualToRect(__cardNumberField.frame, CARD_NUMBER_FIELD_FRAME) ) {
    __cardNumberField.frame = CARD_NUMBER_FIELD_FRAME;
  }
  
  if ( !CGRectEqualToRect(__securityCodeField.frame, SECURITY_CODE_FIELD_FRAME) ) {
    __securityCodeField.frame = SECURITY_CODE_FIELD_FRAME;
  }
  
  if ( !CGRectEqualToRect(__creditCardButton.frame, CARD_BUTTON_FRAME) ) {
    __creditCardButton.frame = CARD_BUTTON_FRAME;
  }
  
  if ( !CGRectEqualToRect(__addressesButton.frame, ADDRESSES_BUTTON_FRAME) ) {
    __addressesButton.frame = ADDRESSES_BUTTON_FRAME;
  }
  
  if ( !CGRectEqualToRect(__restaurantsButton.frame, RESTAURANTS_BUTTON_FRAME) ) {
    __restaurantsButton.frame = RESTAURANTS_BUTTON_FRAME;
  }
  
  if ( !CGRectEqualToRect(__tableView.frame, MENU_TABLE_FRAME) ) {
    __tableView.frame = MENU_TABLE_FRAME;
  }
  
  if ( !CGRectEqualToRect(__datePicker.frame, DATE_PICKER_FRAME)) {
    __datePicker.frame = DATE_PICKER_FRAME;
  }
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  __creditCardButton = nil;
  __addressesButton = nil;
  __restaurantsButton = nil;
  
  OI_RELEASE_SAFELY( __tipField );
  OI_RELEASE_SAFELY( __cardNumberField );
  OI_RELEASE_SAFELY( __securityCodeField );
  OI_RELEASE_SAFELY( __datePicker );
  OI_RELEASE_SAFELY( __tableView );
  OI_RELEASE_SAFELY( __scrollView );
  
  [super dealloc];
}

@end
