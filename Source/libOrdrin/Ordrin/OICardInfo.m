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
 *      Vitezslav Kot (vita@tapmates.com)
 */
#import "OICardInfo.h"
#import "OICore.h"
#import "OIAddress.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Implementation

@implementation OICardInfo {
@private
  NSString *__nickname;
  NSString *__name;
  NSNumber *__number;
  NSNumber *__cvc;
  NSNumber *__lastFiveDigits;
  NSString *__expirationMonth;
  NSString *__type;
  NSString *__expirationYear;
  OIAddress *__address;
}

@synthesize nickname          = __nickname;
@synthesize name              = __name;
@synthesize number            = __number;
@synthesize cvc               = __cvc;
@synthesize lastFiveDigits    = __lastFiveDigits;
@synthesize type              = __type;
@synthesize expirationMonth   = __expirationMonth;
@synthesize expirationYear    = __expirationYear;
@synthesize address           = __address;

#pragma mark -
#pragma mark Lifecycle

- (id)init {
  if (( self = [super init] )) {
    __address = [[OIAddress alloc] init];
  }
  return self;
}

#pragma mark -
#pragma mark NSCopying Protocol

- (id)copyWithZone:(NSZone *)zone {
  id copy = [[[self class] allocWithZone:zone] init];
  
  if (copy) {
    [copy setNickname:[[self.nickname copyWithZone:zone] autorelease]];
    [copy setName:[[self.name copyWithZone:zone] autorelease]];
    [copy setNumber:[[self.number copyWithZone:zone] autorelease]];
    [copy setCvc:[[self.cvc copyWithZone:zone] autorelease]];
    [copy setLastFiveDigits:[[self.lastFiveDigits copyWithZone:zone] autorelease]];
    [copy setType:[[self.type copyWithZone:zone] autorelease]];
    [copy setExpirationMonth:[[self.expirationMonth copyWithZone:zone] autorelease]];
    [copy setExpirationYear:[[self.expirationYear copyWithZone:zone] autorelease]];
    [copy setAddress:[[self.address copyWithZone:zone] autorelease]];
  }
  
  return copy;
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __nickname );
  OI_RELEASE_SAFELY( __name );
  OI_RELEASE_SAFELY( __number );
  OI_RELEASE_SAFELY( __cvc );
  OI_RELEASE_SAFELY( __lastFiveDigits );
  OI_RELEASE_SAFELY( __type );
  OI_RELEASE_SAFELY( __expirationMonth );
  OI_RELEASE_SAFELY( __expirationYear );
  OI_RELEASE_SAFELY( __address );
  
  [super dealloc];
}

@end
