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
#import "OIAPIGenericAuthenticator.h"
#import "OIAPIClient.h"
#import "OICore.h"

@implementation OIAPIGenericAuthenticator {
@private
  NSString *__key;
}

#pragma mark -
#pragma mark Lifecycle

- (id)initWithKey:(NSString *)key {
  if (( self = [super init] )) {
    __key = [key copy];
  }
  return self;
}

- (NSString *)authenticationValue {
  return [NSString stringWithFormat:@"id=\"%@\", version=\"%@\"", __key, OIAPIClientVersion];
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __key );
  
  [super dealloc];
}

@end
