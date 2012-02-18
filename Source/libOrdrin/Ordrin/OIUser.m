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
#import "JSONKit.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Variables

NSString const* OIUserBaseURL = @"https://u-test.ordr.in";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Implementation

@implementation OIUser {
@private
  NSString *__firstName;
  NSString *__lastName;
  NSString *__email;
}

@synthesize firstName = __firstName;
@synthesize lastName  = __lastName;
@synthesize email     = __email;

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __firstName );
  OI_RELEASE_SAFELY( __lastName );
  OI_RELEASE_SAFELY( __email );
  
  [super dealloc];
}

#pragma mark -
#pragma mark Class methods

+ (void)getAccountInfo:(NSString *)email password:(NSString *)password usingBlockUser:(void (^)(OIUser *user))blockUser usingBlockError:(void (^)(NSError *error))blockError; {
  NSString *URL = [NSString stringWithFormat:@"%@/u/%@", OIUserBaseURL, [email urlEncode]];
  
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];
  
  
  [request setCompletionBlock:^{
    
    NSDictionary *json = [[request responseString] objectFromJSONString];
    OIUser *user = [[[OIUser alloc] init] autorelease];
    
    user.firstName = [json objectForKey:@"first_name"];
    user.lastName = [json objectForKey:@"last_name"];
    user.email = [json objectForKey:@"em"];
    
    if ( blockUser ) {
      blockUser(user);
    }
    
  }]; 
  
  [request setFailedBlock:^{
    blockError([request error]);
  }];
  
  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES withUserAuthenticator:[OIAPIUserAuthenticator authenticatorWithEmail:email password:password uri:[NSURL URLWithString:URL]]];
}

+ (void)createNewAccount:(OIUser *)account password:(NSString *)password usingBlock:(void (^)(NSError *error))block {
  NSString *URL = [NSString stringWithFormat:@"%@/u/%@", OIUserBaseURL, [account.email urlEncode]];
  
  __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:URL]];
  
  [request setPostValue:account.firstName forKey:@"first_name"];
  [request setPostValue:account.lastName forKey:@"last_name"];
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

+ (OIUser *)userWithEmail:(NSString *)email firstName:(NSString *)firstName lastName:(NSString *)lastName {
  OIUser *user = [[OIUser alloc] init];
  user.email = email;
  user.firstName = firstName;
  user.lastName = lastName;
  
  return [user autorelease];
}

@end
