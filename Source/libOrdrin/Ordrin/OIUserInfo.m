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

#import "OIUserInfo.h"
#import "OIAPIUserAuthenticator.h"
#import "OICore.h"

@implementation OIUserInfo {
@private
  NSString *__email;
  NSString *__password;
}

@synthesize email     = __email;
@synthesize password  = __password;

#pragma mark -
#pragma mark Instance methods

- (OIAPIUserAuthenticator *)createAuthenticatorWithUri:(NSString *)uri {
  return [OIAPIUserAuthenticator authenticatorWithEmail:__email password:__password uri:[NSURL URLWithString:uri]];
}

#pragma mark -
#pragma Memory management

- (void)dealloc {
  OI_RELEASE_SAFELY( __email );
  OI_RELEASE_SAFELY( __password );
  
  [super dealloc];
}

#pragma mark -
#pragma mark Singleton

+ (OIUserInfo *)sharedInstance {
	static dispatch_once_t pred;
	static OIUserInfo *instance = nil;
  
	dispatch_once(&pred, ^{ instance = [[self alloc] init]; });
	return instance;
}

@end
