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

#import "OIAPIUserAuthenticator.h"
#import "OICore.h"

@implementation OIAPIUserAuthenticator {
@private
  NSString *__email;
  NSString *__hash;
}

#pragma mark -
#pragma mark Lifecycle

- (id)initWithEmail:(NSString *)email password:(NSString *)password uri:(NSURL *)uri {
  if (( self = [super initWithKey:@""] )) {
    __email = [email copy];
    
    NSMutableString *hash = [[NSMutableString alloc] init];
    [hash appendString:password.sha256];
    [hash appendString:email];
    [hash appendString:[uri relativeString]];
    __hash = [[hash sha256] copy];
    [hash release];
  }
  return self;
}

- (NSString *)authenticationValue {
  return [NSString stringWithFormat:@"username=\"%@\", response=\"%@\", version=\"%@\"", __email, __hash, OIAPIClientVersion];
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __email );
  OI_RELEASE_SAFELY( __hash );
  
  [super dealloc];
}

#pragma mark -
#pragma mark Class methods

+ (OIAPIUserAuthenticator *)authenticatorWithEmail:(NSString *)email password:(NSString *)password uri:(NSURL *)uri {
  return [[[OIAPIUserAuthenticator alloc] initWithEmail:email password:password uri:uri] autorelease];
}

@end
