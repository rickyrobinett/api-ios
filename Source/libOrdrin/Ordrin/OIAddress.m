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

#import "OIAddress.h"
#import "OICore.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "OIRestaurant.h"
#import "OIUser.h"
#import "OIUserInfo.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Variables

NSString *const OIAddressesBaseURL = @"https://r-test.ordr.in";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Implementation

@interface OIAddress (Private)
+ (ASIFormDataRequest *)createRequestForCreateOrUpdateActionWithAddress:(OIAddress *)address;
@end

@implementation OIAddress {
@private
  NSString *__nickname;
  NSString *__address1;
  NSString *__address2;
  NSString *__city;
  NSString *__state;
  NSNumber *__postalCode;
  NSString *__phoneNumber;
  NSString *__userId;  
}

@synthesize nickname      = __nickname;
@synthesize address1      = __address1;
@synthesize address2      = __address2;
@synthesize city          = __city;
@synthesize state         = __state;
@synthesize postalCode    = __postalCode;
@synthesize phoneNumber   = __phoneNumber;
@synthesize userId        = __userId;

#pragma mark -
#pragma mark Properties

- (NSString *)description {
  return [NSString stringWithFormat:@"nickname: %@\naddress1: %@\naddress2: %@\ncity: %@\nstate: %@\nzip code: %d\nphone: %@\nuserId: %@", __nickname, [__address1 urlEncode], [__address2 urlEncode], [__city urlEncode], __state, __postalCode.intValue, __phoneNumber, __userId];
}

#pragma mark -
#pragma mark Instance methods

- (NSString *)addressAsString {
  return [NSString stringWithFormat:@"/%@/%@/%@", __postalCode, [__address1 urlEncode], [__city urlEncode]];
}

- (void)updateAddressWithAddress:(OIAddress *)address usingBlock:(void (^)(NSError *error))block {
  OIUserInfo *userInfo = [OIUserInfo sharedInstance];  
  NSString *URLParams = [NSString stringWithFormat:@"/u/%@/addrs/%@", userInfo.email, address.nickname.urlEncode];
  __block ASIFormDataRequest *request = [OIAddress createRequestForCreateOrUpdateActionWithAddress:address];
  
  [request setCompletionBlock:^void() {
    NSDictionary *json = [[request responseString] objectFromJSONString];
    NSNumber *error = [json objectForKey:@"_error"];
    
    if ( error.intValue == 0 ) {
      self.nickname = address.nickname;
      self.address1 = address.address1;
      self.address2 = address.address2;
      self.city = address.city;
      self.state = address.state;
      self.postalCode = address.postalCode;
      self.phoneNumber = address.phoneNumber;
      
      if ( block ) {
        block( nil );
      }
    } else {
      NSString *msg = [json objectForKey:@"msg"];
      NSError *error = [NSError errorWithDomain:msg code:0 userInfo:nil];
      if ( block ) {
        block( error );
      }      
    }
  }];

  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES userAuthenticator:[userInfo createAuthenticatorWithUri:URLParams]];  
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __userId );  
  OI_RELEASE_SAFELY( __nickname );
  OI_RELEASE_SAFELY( __address1 );
  OI_RELEASE_SAFELY( __address2 );
  OI_RELEASE_SAFELY( __city );
  OI_RELEASE_SAFELY( __state );
  OI_RELEASE_SAFELY( __postalCode );
  OI_RELEASE_SAFELY( __phoneNumber );
  
  [super dealloc];
}

#pragma mark -
#pragma mark Class methods

+ (void)addAddress:(OIAddress *)address usingBlock:(void (^)(NSError *error))block {
  OIUserInfo *userInfo = [OIUserInfo sharedInstance]; 
  NSString *URLParams = [NSString stringWithFormat:@"/u/%@/addrs/%@",userInfo.email.urlEncode, address.nickname.urlEncode];
  
  __block ASIFormDataRequest *request = [OIAddress createRequestForCreateOrUpdateActionWithAddress:address];
  
  [request setCompletionBlock:^{
    NSDictionary *json = [[request responseString] objectFromJSONString];
    if ( json ) {
      NSNumber *error = [json objectForKey:@"_error"];
      if ( error.integerValue == 0 ) {
        block( nil );        
      } else {
        NSString *msg = [json objectForKey:@"msg"];
        NSError *error = [NSError errorWithDomain:msg code:0 userInfo:nil];
        block( error );
      }
    }
  }];
  
  [request setFailedBlock:^{
    block([request error]);
  }];
  
  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES userAuthenticator:[userInfo createAuthenticatorWithUri:URLParams]];  
}

+ (void)loadAddressesUsingBlock:(void (^)(NSMutableArray *addresses))block {
  OIUserInfo *userInfo = [OIUserInfo sharedInstance];
  NSString *URLParams = [NSString stringWithFormat:@"/u/%@/addrs",userInfo.email.urlEncode];
  NSString *URL = [NSString stringWithFormat:@"%@%@", OIUserBaseURL, URLParams];
  
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];
  
  [request setCompletionBlock:^{
      
    NSDictionary *json = [[request responseString] objectFromJSONString];
    NSArray *allKeys = [json allKeys];
   
    NSString *item;
      
    NSMutableArray *newAddresses = [NSMutableArray array];
      
    for (item in allKeys) {
        
      NSDictionary *addressDict = [json objectForKey:item];
      
      if( addressDict ) {
        OIAddress *address = [[OIAddress alloc] init];
        address.nickname = item;
        address.address1 =   [addressDict objectForKey:@"addr"];
        address.address2 =   [addressDict objectForKey:@"addr2"];
        address.city =   [addressDict objectForKey:@"city"];
        address.state =   [addressDict objectForKey:@"state"];
        address.postalCode =   [addressDict objectForKey:@"zip"];
        address.phoneNumber =   [addressDict objectForKey:@"phone"];
        [newAddresses addObject:address];
        
        OI_RELEASE_SAFELY( address );
      }
    }
    
    if ( block ) {  
      block( newAddresses );
    }    
  }];
   
  [request setFailedBlock:^{  
    block( [NSArray array] );
  }];

  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES userAuthenticator:[userInfo createAuthenticatorWithUri:URLParams]];  
}

+ (void)loadAddressByNickname:(NSString *)nickname usingBlock:(void (^)(OIAddress *address))block {
  OIUserInfo *userInfo = [OIUserInfo sharedInstance];  
  NSString *URLParams = [NSString stringWithFormat:@"/u/%@/addrs/%@",userInfo.email.urlEncode, nickname.urlEncode];
  NSString *URL = [NSString stringWithFormat:@"%@%@", OIUserBaseURL, URLParams];
  
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];
  
  [request setCompletionBlock:^{
    
    NSDictionary *json = [[request responseString] objectFromJSONString];
    
    if( json ) {
      OIAddress *address = [[[OIAddress alloc] init] autorelease];
      address.nickname = nickname;
      address.address1 = [json objectForKey:@"addr"];
      address.address2 = [json objectForKey:@"addr2"];
      address.city = [json objectForKey:@"city"];
      address.state = [json objectForKey:@"state"];
      address.postalCode = [json objectForKey:@"zip"];
      address.phoneNumber = [json objectForKey:@"phone"];   
      
      if ( block ) {
        block( address );
      }
    }
    else
      block( nil );
  }];
  
  [request setFailedBlock:^{
    block( nil );
  }];
  
  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES userAuthenticator:[userInfo createAuthenticatorWithUri:URLParams]];
}

+ (void)deleteAddressByNickname:(NSString *)nickname usingBlock:(void (^)(NSError *error))block {
  OIUserInfo *userInfo = [OIUserInfo sharedInstance];
  NSString *URLParams = [NSString stringWithFormat:@"/u/%@/addrs/%@",userInfo.email.urlEncode, nickname.urlEncode];  
  NSString *URL = [NSString stringWithFormat:@"%@%@", OIUserBaseURL, URLParams];
  
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];
  [request setRequestMethod:@"DELETE"];
  [request setCompletionBlock:^{
    
    NSDictionary *json = [[request responseString] objectFromJSONString];
    if ( json ) {
      NSNumber *error = [json objectForKey:@"_error"];
      if ( error.intValue == 0 ) {
        block( nil );        
      } else {
        NSString *msg = [json objectForKey:@"msg"];
        NSError *error = [NSError errorWithDomain:msg code:0 userInfo:nil];
        block( error );
      }
    }
  }];
  
  [request setFailedBlock:^{
    block( [request error] );
  }]; 
  
  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES userAuthenticator:[userInfo createAuthenticatorWithUri:URLParams]];
}

+ (OIAddress *)addressWithStreet:(NSString *)street city:(NSString *)city postalCode:(NSNumber *)postalCode {
  OIAddress *address = [[[OIAddress alloc] init] autorelease];
  address.address1 = street;
  address.city = city;
  address.postalCode = postalCode;
  
  return address;
}

@end

#pragma mark -
#pragma mark Private methods

@implementation OIAddress (Private)

+ (ASIFormDataRequest *)createRequestForCreateOrUpdateActionWithAddress:(OIAddress *)address {
  OIUserInfo *userInfo = [OIUserInfo sharedInstance];
  NSString *email = userInfo.email;  
  NSString *URLParams = [NSString stringWithFormat:@"/u/%@/addrs/%@", email.urlEncode, address.nickname.urlEncode];
  NSString *URL = [NSString stringWithFormat:@"%@%@", OIUserBaseURL, URLParams];
  
  ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:URL]];
  [request setRequestMethod:@"PUT"];
    
  [request setPostValue:userInfo.email forKey:@"email"];
  [request setPostValue:[userInfo.password sha256] forKey:@"password"];
  
  [request setPostValue:OI_EMPTY_STR_IF_NIL(address.nickname) forKey:@"nick"];
  [request setPostValue:OI_EMPTY_STR_IF_NIL(address.address1) forKey:@"addr"];
  [request setPostValue:OI_EMPTY_STR_IF_NIL(address.address2) forKey:@"addr2"];
  [request setPostValue:OI_EMPTY_STR_IF_NIL(address.city) forKey:@"city"];
  [request setPostValue:OI_EMPTY_STR_IF_NIL(address.state) forKey:@"state"];
  [request setPostValue:OI_ZERO_IF_NIL(address.postalCode) forKey:@"zip"];
  [request setPostValue:OI_EMPTY_STR_IF_NIL(address.phoneNumber) forKey:@"phone"];
  
  return request;
}

@end