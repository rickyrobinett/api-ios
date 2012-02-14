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
#import "OIDelivery.h"
#import "OICore.h"

@implementation OIDelivery {
@private
  BOOL __available;
  NSNumber *__minimumAmount;
  NSDate   *__expectedTime;
  NSString *__message;
  NSArray  *__meals;
  NSString *__ID;
  NSNumber *__fee;
  NSNumber *__tax;
}

@synthesize available     = __available;
@synthesize minimumAmount = __minimumAmount;
@synthesize expectedTime  = __expectedTime;
@synthesize message       = __message;
@synthesize meals         = __meals;
@synthesize ID            = __ID;
@synthesize fee           = __fee;
@synthesize tax           = __tax;

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __minimumAmount );
  OI_RELEASE_SAFELY( __expectedTime );
  OI_RELEASE_SAFELY( __message );
  OI_RELEASE_SAFELY( __meals );
  OI_RELEASE_SAFELY( __ID );
  OI_RELEASE_SAFELY( __fee );
  OI_RELEASE_SAFELY( __tax );
  [super dealloc];
}

@end