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

#import "RestaurantListModel.h"
#import "OICore.h"
#import "OIRestaurantBase.h"
#import "OIAddress.h"
#import "OIDateTime.h"

@interface RestaurantListModel (Private)
- (void)initRestaurantsWithAddress:(OIAddress *)address;
@end

@implementation RestaurantListModel

@synthesize items = __items;

#pragma mark -
#pragma mark Initializations

- (id)initWithAddress:(OIAddress *)address {
  self = [super init];
  if ( self ) {  
    [self initRestaurantsWithAddress:address];
  }
  
  return self;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  OI_RELEASE_SAFELY( __items );
  
  [super dealloc];
}

@end

#pragma mark -
#pragma mark Private

@implementation RestaurantListModel (Private)

- (void)initRestaurantsWithAddress:(OIAddress *)address {
  [OIRestaurantBase restaurantsNearAddress:address availableAt:[OIDateTime dateTimeASAP] usingBlock:^void( NSArray *restaurants ) {
    __items = [[NSMutableArray alloc] initWithArray:restaurants];
    [[NSNotificationCenter defaultCenter] postNotificationName:kRestaurantsModelDidFinishNotification object:nil];
  }];
}

@end
