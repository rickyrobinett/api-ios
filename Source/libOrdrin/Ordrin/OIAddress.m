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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Interface

@interface OIAddress()< NSCopying>

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Implementation

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
#pragma mark NSCopying Protocol

- (id)copyWithZone:(NSZone *)zone {
  id copy = [[[self class] allocWithZone:zone] init];

  if (copy) {
    [copy setNickname:[[self.nickname copyWithZone:zone] autorelease]];
    [copy setAddress1:[[self.address1 copyWithZone:zone] autorelease]];
    [copy setAddress2:[[self.address2 copyWithZone:zone] autorelease]];
    [copy setCity:[[self.city copyWithZone:zone] autorelease]];
    [copy setState:[[self.state copyWithZone:zone] autorelease]];
    [copy setPostalCode:[[self.postalCode copyWithZone:zone] autorelease]];
    [copy setPhoneNumber:[[self.phoneNumber copyWithZone:zone] autorelease]];
  }
  
  return copy;
}
#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __nickname );
  OI_RELEASE_SAFELY( __address1 );
  OI_RELEASE_SAFELY( __address2 );
  OI_RELEASE_SAFELY( __city );
  OI_RELEASE_SAFELY( __state );
  OI_RELEASE_SAFELY( __postalCode );
  OI_RELEASE_SAFELY( __phoneNumber );
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