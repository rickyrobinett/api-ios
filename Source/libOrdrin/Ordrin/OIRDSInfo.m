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

#import "OIRDSInfo.h"
#import "OICore.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Implementation

@implementation OIRDSInfo {
@private
  NSURL     *__logoUrl;
  NSString  *__name;
}

@synthesize logoUrl   = __logoUrl;
@synthesize name      = __name;


#pragma mark -
#pragma mark Properties

- (NSString *)description {
  return [NSString stringWithFormat:@"name: %@\nlogoUrl: %@", __name, __logoUrl];
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __logoUrl );
  OI_RELEASE_SAFELY( __name );
  [super dealloc];
} 
@end