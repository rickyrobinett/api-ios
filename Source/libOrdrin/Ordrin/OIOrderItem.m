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

#import "OIOrderItem.h"
#import "OICore.h"

@implementation OIOrderItem {
@private
  NSString *__id;
  NSString *__name;
  NSNumber *__price;
  NSNumber *__quantity;
  NSMutableArray *__opts;
}

@synthesize ID        = __id;
@synthesize name      = __name;
@synthesize price     = __price;
@synthesize quantity  = __quantity;
@synthesize opts      = __opts;

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  OI_RELEASE_SAFELY( __id );
  OI_RELEASE_SAFELY( __name );
  OI_RELEASE_SAFELY( __price );
  OI_RELEASE_SAFELY( __quantity );
  OI_RELEASE_SAFELY( __opts );
  
  [super dealloc];
}
@end
