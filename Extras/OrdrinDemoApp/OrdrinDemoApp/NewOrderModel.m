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

#import "NewOrderModel.h"
#import "OIAddress.h"
#import "OIRestaurantBase.h"
#import "OIDateTime.h"
#import "OICore.h"

@interface NewOrderModel (Private)
- (void)initAddresses;
- (void)initRestaurants;
@end

@implementation NewOrderModel

@synthesize restaurants = __restaurants;
@synthesize addresses   = __addresses;

#pragma mark -
#pragma mark Initializations

- (id)initWithAddress:(OIAddress *)address {
  self = [super init];
  if ( self ) {
    __address = [address retain];
    [self initRestaurants];
    [self initAddresses];
  }
  
  return self;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  OI_RELEASE_SAFELY( __address );  
  OI_RELEASE_SAFELY( __restaurants );
  OI_RELEASE_SAFELY( __addresses );  
  [super dealloc];
}

@end

#pragma mark -
#pragma mark Private

@implementation NewOrderModel (Private)

- (void)initAddresses {
  [OIAddress loadAddressesUsingBlock:^void( NSMutableArray *addresses ) {
    __addresses = [[NSArray alloc] initWithArray:addresses];
  }];
}

- (void)initRestaurants {
  [OIRestaurantBase restaurantsNearAddress:__address availableAt:[OIDateTime dateTimeASAP] usingBlock:^void( NSArray *restaurants ) {
    __restaurants = [[NSArray alloc] initWithArray:restaurants];
  }];
}

@end