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
#import "OIAddress.h"
#import "OICore.h"

@implementation OIAddress {
@private
  NSString *__nickname;
  NSString *__address1;
  NSString *__address2;
  NSString *__city;
  NSString *__state;
  NSNumber *__postalCode;
  NSString *__phoneNumber;
}

@synthesize nickname      = __nickname;
@synthesize address1      = __address1;
@synthesize address2      = __address2;
@synthesize city          = __city;
@synthesize state         = __state;
@synthesize postalCode    = __postalCode;
@synthesize phoneNumber   = __phoneNumber;

#pragma mark -
#pragma mark Properties

- (NSString *)description {
  return [NSString stringWithFormat:@"/%@/%@/%@", __postalCode, [__address1 urlEncode], [__city urlEncode]];
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __address1 );
  OI_RELEASE_SAFELY( __city );
  OI_RELEASE_SAFELY( __postalCode );
  [super dealloc];
}

#pragma mark -
#pragma mark Class methods

+ (OIAddress *)addressWithStreet:(NSString *)street city:(NSString *)city postalCode:(NSNumber *)postalCode {
  OIAddress *address = [[OIAddress alloc] init];
  address.address1 = street;
  address.city = city;
  address.postalCode = postalCode;
  
  return [address autorelease];
}

@end