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
#import "OIUser.h"
#import "OICore.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Variables

NSString const* OIUserBaseURL = @"https://u-test.ordr.in";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Implementation

@implementation OIUser {
@private
  NSString *__firstname;
  NSString *__lastname;
  NSString *__email;
}

@synthesize firstname = __firstname;
@synthesize lastname  = __lastname;
@synthesize email     = __email;

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __firstname );
  OI_RELEASE_SAFELY( __lastname );
  OI_RELEASE_SAFELY( __email );
  
  [super dealloc];
}

#pragma mark -
#pragma mark Class methods

+ (void)createNewAccount:(OIUser *)account password:(NSString *)password usingBlock:(void (^)(NSError *error))block {
  NSString *URL = [NSString stringWithFormat:@"%@/u/%@", OIUserBaseURL, [account.email urlEncode]];
  
  __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:URL]];
  [request setPostValue:account.firstname forKey:@"first_name"];
  [request setPostValue:account.lastname forKey:@"last_name"];
  [request setPostValue:[password sha1] forKey:@"password"];
  
  [request setCompletionBlock:^{
    OIDLOG(@"response: %@", [request responseString]);
  }];
  
  [request setFailedBlock:^{
    block([request error]);
  }];
  
  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES];
}

+ (OIUser *)userWithEmail:(NSString *)email firstname:(NSString *)firstname lastname:(NSString *)lastname {
  OIUser *user = [[OIUser alloc] init];
  user.email = email;
  user.firstname = firstname;
  user.lastname = lastname;
  
  return [user autorelease];
}

+ (void)userWithEmail:(NSString *)email password:(NSString *)password usingBlock:(void (^)(OIUser *user))block {
  NSString *urlString = [NSString stringWithFormat:@"%@/u/%@", OIUserBaseURL, [email urlEncode]];
  NSURL *URL = [NSURL URLWithString:urlString];
  
  
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
  [request setCompletionBlock:^ {
    OIDLOG(@"response: %@", [request responseString]);
  }];
  
  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request 
             authorized:YES 
          authenticator:[OIAPIUserAuthenticator authenticatorWithEmail:email password:password uri:URL]];
}

@end
