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
 *      Vitezslav Kot (vita@tapmates.com)
 */

#import "OIUser.h"
#import "OICore.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "OIAddress.h"

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
  NSString *__password;
  NSArray  *__addresses;
  NSArray  *__creditCards;
  NSArray  *__orders;
}

@synthesize firstName = __firstName;
@synthesize lastName  = __lastName;
@synthesize email     = __email;
@synthesize password  = __password;
@synthesize addresses = __addresses;
@synthesize creditCards = __creditCards;
@synthesize orders    = __orders;


#pragma mark -
#pragma mark Instance methods

- (void)loadAddressesUsingBlock:(void (^)(NSError *error))block {
  NSString *URL = [NSString stringWithFormat:@"%@/u/%@/addrs", OIUserBaseURL, [__email urlEncode]];
  
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];
  
  [request setCompletionBlock:^{
    
    NSDictionary *json = [[request responseString] objectFromJSONString];
    NSArray *allKeys = [json allKeys];
    
    NSLog(@"%@", allKeys);
    NSLog(@"%@", json);
    
    //    OIUser *user = [[[OIUser alloc] init] autorelease];
    //    
    //    user.firstName = [json objectForKey:@"first_name"];
    //    user.lastName = [json objectForKey:@"last_name"];
    //    user.email = [json objectForKey:@"em"];
    
    if ( block ) {
      block(nil);
    }
    
  }];
  
  [request setFailedBlock:^{
    block([request error]);
  }];
  
  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES userAuthenticator:[OIAPIUserAuthenticator authenticatorWithEmail:__email password:__password uri:[NSURL URLWithString:@""]]];
}

- (void)loadAddressesByNickname:(NSString *)nickname usingBlock:(void (^)(OIAddress *address))block {
  
}

- (void)addOrChangeAddress:(OIAddress *)address usingBlock:(void (^)(NSError *error))block {
  
  NSString *URL = [NSString stringWithFormat:@"%@/u/%@/addrs/%@", OIUserBaseURL, [__email urlEncode], [[address nickname] urlEncode]];
  NSString *URLParams = [NSString stringWithFormat:@"u/%@/addrs/%@",[__email urlEncode], [[address nickname] urlEncode]];
  
  __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:URL]];
  [request setRequestMethod:@"PUT"];
  
  [request setPostValue:__email forKey:@"email"];
  [request setPostValue:[__password sha256] forKey:@"password"];
  [request setPostValue:address.nickname forKey:@"nick"];
  [request setPostValue:address.address1 forKey:@"addr"];
  [request setPostValue:address.address2 forKey:@"addr2"];
  [request setPostValue:address.city forKey:@"city"];
  [request setPostValue:address.state forKey:@"state"];
  [request setPostValue:address.postalCode forKey:@"zip"];
  [request setPostValue:address.phoneNumber forKey:@"phone"];
  
  [request setCompletionBlock:^{
    
    NSDictionary *json = [[request responseString] objectFromJSONString];
    NSLog(@"%@", json);
                          
    OIAddress *item;
    for (item in __addresses) {
      
      if([address.nickname isEqualToString:[item nickname]]) {
        [item copy:address];
      }
    }
    
    block(nil);
  }];
  
  [request setFailedBlock:^{
    block([request error]);
  }];
  
  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES userAuthenticator:[OIAPIUserAuthenticator authenticatorWithEmail:__email password:__password uri:[NSURL URLWithString:URLParams]]];
}

- (void)deleteAddress:(NSString *)nickname usingBlock:(void (^)(NSError *error))block {
  
}

- (void)loadCreditCardsUsingBlock:(void (^)(NSError *error))block {
  
}

- (void)loadCreditCardByNickname:(NSString *)nickname usingBlock:(void (^)(OICardInfo *creditCard))block {
  
}

- (void)addOrChangeCreditCard:(OICardInfo *)creditCard usingBlock:(void (^)(NSError *error))block {
  
}

- (void)deleteCreditCard:(NSString *)nickname usingBlock:(void (^)(NSError *error))block {
  
}

- (void)loadOrderHistoryUsingBlock:(void (^)(NSError *error))block {
  
}

- (void)loadOrderByID:(NSString *)ID usingBlock:(void (^)(OIOrder *order))block {
  
}

- (void)updatePassword:(NSString *) password usingBlock:(void (^)(NSError *error))block {
  
}


#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __firstName );
  OI_RELEASE_SAFELY( __lastName );
  OI_RELEASE_SAFELY( __email );
  OI_RELEASE_SAFELY( __password );
  OI_RELEASE_SAFELY( __addresses );
  OI_RELEASE_SAFELY( __creditCards );
  [super dealloc];
}

#pragma mark -
#pragma mark Class methods

+ (void)accountInfo:(NSString *)email password:(NSString *)password usingBlockUser:(void (^)(OIUser *user))blockUser usingBlockError:(void (^)(NSError *error))blockError; {
  NSString *URL = [NSString stringWithFormat:@"%@/u/%@", OIUserBaseURL, [email urlEncode]];
  NSString *URLParams = [NSString stringWithFormat:@"u/%@/",[email urlEncode]];
  
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];
  
  [request setCompletionBlock:^{
    
    NSDictionary *json = [[request responseString] objectFromJSONString];
    OIUser *user = [[[OIUser alloc] init] autorelease];
    
    user.password = password;
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
  [client appendRequest:request authorized:YES userAuthenticator:[OIAPIUserAuthenticator authenticatorWithEmail:email password:password uri:[NSURL URLWithString:URLParams]]];
}

+ (void)createNewAccount:(OIUser *)account password:(NSString *)password usingBlock:(void (^)(NSError *error))block {
  NSString *URL = [NSString stringWithFormat:@"%@/u/%@", OIUserBaseURL, [account.email urlEncode]];
  
  __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:URL]];
  
  [request setPostValue:account.firstName forKey:@"first_name"];
  [request setPostValue:account.lastName forKey:@"last_name"];
  [request setPostValue:[password sha256] forKey:@"password"];
  
  [request setCompletionBlock:^{
    block(nil);
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
