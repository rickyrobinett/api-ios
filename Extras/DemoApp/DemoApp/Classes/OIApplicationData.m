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

#import "OIApplicationData.h"
#import "OICore.h"

static OIApplicationData *sharedAppData = nil;

@implementation OIApplicationData {
@private
  BOOL __userLogged;
  OIUser *__currentUser;
}

@synthesize userLogged  = __userLogged;
@synthesize currentUser  = __currentUser;

- (id)init {
  if (self = [super init]) {
    __userLogged = NO;
  }
  return self;
}

- (void)dealloc {
  OI_RELEASE_SAFELY( __currentUser );
  [super dealloc];
}

#pragma mark Singleton

+ (id)sharedInstance {
  @synchronized(self) {
    if (sharedAppData == nil)
      sharedAppData = [[self alloc] init];
  }
  return sharedAppData;
}

@end
