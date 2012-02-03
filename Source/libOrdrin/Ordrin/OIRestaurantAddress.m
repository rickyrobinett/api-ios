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
 */
#import "OIRestaurantAddress.h"
#import "OICore.h"

@implementation OIRestaurantAddress {
@private
  NSString *__street;
  NSString *__city;
  NSNumber *__postalCode;
}

@synthesize street      = __street;
@synthesize city        = __city;
@synthesize postalCode  = __postalCode;

#pragma mark -
#pragma mark Properties

- (NSString *)description {
  return [NSString stringWithFormat:@"/%@/%@/%@", __postalCode, [__street urlEncode], [__city urlEncode]];
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __street );
  OI_RELEASE_SAFELY( __city );
  OI_RELEASE_SAFELY( __postalCode );
  [super dealloc];
}

#pragma mark -
#pragma mark Class methods

+ (OIRestaurantAddress *)restaurantAddressWithStreet:(NSString *)street city:(NSString *)city postalCode:(NSNumber *)postalCode {
  OIRestaurantAddress *address = [[OIRestaurantAddress alloc] init];
  address.street = street;
  address.city = city;
  address.postalCode = postalCode;

  return [address autorelease];
}

@end