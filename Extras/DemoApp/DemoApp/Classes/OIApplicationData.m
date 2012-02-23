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
 *      Petr Reichl (petr@tapmates.com)
 */

#import "OIApplicationData.h"
#import "OICore.h"
#import "OIUser.h"

@implementation OIApplicationData {
@private
  BOOL __userLogged;
  OIUser *__currentUser;
}

@synthesize userLogged  = __userLogged;
@synthesize currentUser  = __currentUser;

#pragma mark -
#pragma mark Instance methods

- (id)init {
  if ((self = [super init])) {
    __userLogged = NO;
  }
  return self;
}

- (void)logout {
  __userLogged = NO;
  OI_RELEASE_SAFELY(__currentUser );
}

- (void)dealloc {
  OI_RELEASE_SAFELY( __currentUser );
  [super dealloc];
}

#pragma mark -
#pragma mark Singleton

+ (OIApplicationData *)sharedInstance {
	static dispatch_once_t pred;
	static OIApplicationData *instance = nil;

	dispatch_once(&pred, ^{ instance = [[self alloc] init]; });
	return instance;
}

@end
