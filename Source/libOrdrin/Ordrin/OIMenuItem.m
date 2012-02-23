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
 *      Vitezslav Kot (vita@tapmates.com)
 */
#import "OIMenuItem.h"
#import "OICore.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Implementation

@implementation OIMenuItem {
@private
  NSString  *__id;
  NSNumber  *__availableForMealId;
  NSString  *__name;
  NSString  *__description;
  NSNumber  *__price;
  BOOL __orderable;  
  BOOL __children;
}

@synthesize ID                  = __id;
@synthesize availableForMealId  = __availableForMealId;
@synthesize orderable           = __orderable;
@synthesize name                = __name;
@synthesize description         = __description;
@synthesize price               = __price;
@synthesize children            = __children;

#pragma mark -
#pragma mark Properties

- (NSString *)description {
  return [NSString stringWithFormat:@"name: %@", __name];
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __id );
  OI_RELEASE_SAFELY( __availableForMealId);
  OI_RELEASE_SAFELY( __name );
  OI_RELEASE_SAFELY( __description );
  OI_RELEASE_SAFELY( __price );
  [super dealloc];
}
@end
