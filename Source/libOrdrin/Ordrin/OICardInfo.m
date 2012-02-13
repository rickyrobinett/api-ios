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
#import "OICardInfo.h"
#import "OICore.h"

@implementation OICardInfo {
@private
  NSString *__name;
  NSNumber *__number;
  NSNumber *__cvc;
  NSString *__expiration;
  NSString *__address;
  NSString *__address2;
  NSString *__city;
  NSString *__state;
  NSString *__postalCode;
}

@synthesize name        = __name;
@synthesize number      = __number;
@synthesize cvc         = __cvc;
@synthesize expiration  = __expiration;
@synthesize address     = __address;
@synthesize address2    = __address2;
@synthesize city        = __city;
@synthesize state       = __state;
@synthesize postalCode  = __postalCode;

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __name );
  OI_RELEASE_SAFELY( __number );
  OI_RELEASE_SAFELY( __cvc );
  OI_RELEASE_SAFELY( __expiration );
  OI_RELEASE_SAFELY( __address );
  OI_RELEASE_SAFELY( __address2 );
  OI_RELEASE_SAFELY( __city );
  OI_RELEASE_SAFELY( __state );
  OI_RELEASE_SAFELY( __postalCode );
  
  [super dealloc];
}

@end
