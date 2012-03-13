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
#import "OICore.h"

#define LEFT_PADDING                  10
#define TOP_PADDING                   10

#define BUTTON_WIDTH                  300
#define BUTTON_HEIGHT                 40

#define RESTAURANTS_BUTTON_FRAME      CGRectMake (LEFT_PADDING, TOP_PADDING, BUTTON_WIDTH, BUTTON_HEIGHT)

@implementation NewOrderView

@synthesize restaurantsButton = __restaurantsButton;

#pragma mark -
#pragma mark Initializations

- (id)init {
  self = [super init];
  if ( self ) {
    __scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    __scrollView.contentSize = CGSizeMake(320, 1000);
    __scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    __restaurantsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [__restaurantsButton setTitle:@"No restaurant choosen" forState:UIControlStateNormal];
    
    [__scrollView addSubview:__restaurantsButton];
    
    [self addSubview:__scrollView];
  }
  
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  if ( !CGRectEqualToRect(__scrollView.frame, self.frame) ) {
    __scrollView.frame = self.frame;
  }
  
  if ( !CGRectEqualToRect(__restaurantsButton.frame, RESTAURANTS_BUTTON_FRAME) ) {
    __restaurantsButton.frame = RESTAURANTS_BUTTON_FRAME;
  }
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  __restaurantsButton = nil;
  OI_RELEASE_SAFELY( __scrollView );
  [super dealloc];
}

@end
