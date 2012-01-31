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
#import "OIAPIClient.h"

@implementation OIAPIClient {

}

#pragma mark -
#pragma mark Lifecycle

- (id)init {
  if (( self = [super init] )) {

  }
  return self;
}

#pragma mark -
#pragma mark Singleton

+ (OIAPIClient *)sharedInstance {
	static dispatch_once_t pred;
	static OIAPIClient *instance = nil;

	dispatch_once(&pred, ^{ instance = [[self alloc] init]; });
	return instance;
}

@end