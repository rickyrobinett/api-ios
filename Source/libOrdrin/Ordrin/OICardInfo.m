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

#import "OICardInfo.h"
#import "OICore.h"
#import "OIAddress.h"
#import "OIUserInfo.h"
#import "OIUser.h"
#import "JSONKit.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Implementation

@interface OICardInfo (Private)
+ (ASIFormDataRequest *)createRequestForCreateOrUpdateActionWithCreditCard:(OICardInfo *)creditCard;
@end

@implementation OICardInfo {
@private
  NSString *__nickname;
  NSString *__name;
  NSNumber *__number;
  NSNumber *__cvc;
  NSNumber *__lastFiveDigits;
  NSString *__expirationMonth;
  NSString *__type;
  NSString *__expirationYear;
  OIAddress *__address;
}

@synthesize nickname          = __nickname;
@synthesize name              = __name;
@synthesize number            = __number;
@synthesize cvc               = __cvc;
@synthesize lastFiveDigits    = __lastFiveDigits;
@synthesize type              = __type;
@synthesize expirationMonth   = __expirationMonth;
@synthesize expirationYear    = __expirationYear;
@synthesize address           = __address;

#pragma mark -
#pragma mark Lifecycle

- (id)init {
  if (( self = [super init] )) {
    __address = [[OIAddress alloc] init];
  }
  return self;
}

- (void)updateCreditCardWithCard:(OICardInfo *)creditCard usingBlock:(void (^)(NSError *error))block {
  OIUserInfo *userInfo = [OIUserInfo sharedInstance];
  NSString *URLParams = [NSString stringWithFormat:@"/u/%@/ccs/%@",userInfo.email.urlEncode, creditCard.nickname.urlEncode];    
  __block ASIFormDataRequest *request = [OICardInfo createRequestForCreateOrUpdateActionWithCreditCard:creditCard];
  
  [request setCompletionBlock:^{
    NSDictionary *json = [[request responseString] objectFromJSONString];    
    if ( json ) {
      NSNumber *error = [json objectForKey:@"_error"];
      if ( error.intValue == 0 ) {
        __nickname = creditCard.nickname;
        __name = creditCard.name;
        __number = creditCard.number;
        __cvc = creditCard.cvc;
        __lastFiveDigits = creditCard.lastFiveDigits;
        __type = creditCard.type;
        __expirationMonth = creditCard.expirationMonth;
        __expirationYear = creditCard.expirationYear;
        __address = creditCard.address;
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

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __nickname );
  OI_RELEASE_SAFELY( __name );
  OI_RELEASE_SAFELY( __number );
  OI_RELEASE_SAFELY( __cvc );
  OI_RELEASE_SAFELY( __lastFiveDigits );
  OI_RELEASE_SAFELY( __type );
  OI_RELEASE_SAFELY( __expirationMonth );
  OI_RELEASE_SAFELY( __expirationYear );
  OI_RELEASE_SAFELY( __address );
  
  [super dealloc];
}

#pragma mark -
#pragma mark Class methods

+ (void)addCreditCard:(OICardInfo *)creditCard usingBlock:(void (^)(NSError *error))block {
  OIUserInfo *userInfo = [OIUserInfo sharedInstance];
  NSString *URLParams = [NSString stringWithFormat:@"/u/%@/ccs/%@",userInfo.email.urlEncode, creditCard.nickname.urlEncode];    
  __block ASIFormDataRequest *request = [OICardInfo createRequestForCreateOrUpdateActionWithCreditCard:creditCard];
  
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

+ (void)loadCreditCardsUsingBlock:(void (^)(NSMutableArray *creditCards) )block {
  OIUserInfo *userInfo = [OIUserInfo sharedInstance];
  NSString *URLParams = [NSString stringWithFormat:@"/u/%@/ccs",userInfo.email.urlEncode];
  NSString *URL = [NSString stringWithFormat:@"%@%@", OIUserBaseURL, URLParams];
  
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];
  
  [request setCompletionBlock:^{    
    NSDictionary *json = [[request responseString] objectFromJSONString];
    NSArray *allKeys = [json allKeys];    
    NSString *item;
    
    NSMutableArray *newCardsInfo = [NSMutableArray array];
    
    for (item in allKeys) {      
      NSDictionary *cardInfoDict = [json objectForKey:item];
      
      if( cardInfoDict ) {
        OICardInfo *cardInfo = [[OICardInfo alloc] init];
        
        cardInfo.nickname = item;
        cardInfo.name = [json objectForKey:@"name"];
        cardInfo.lastFiveDigits = [json objectForKey:@"cc_last5"];
        cardInfo.type = [json objectForKey:@"type"];
        cardInfo.expirationMonth = [json objectForKey:@"expiry_month"];
        cardInfo.expirationYear = [json objectForKey:@"expiry_year"];
        cardInfo.address.address1 =   [json objectForKey:@"addr"];
        cardInfo.address.address2 =   [json objectForKey:@"addr2"];
        cardInfo.address.city =   [json objectForKey:@"city"];
        cardInfo.address.state =   [json objectForKey:@"state"];
        cardInfo.address.postalCode =   [json objectForKey:@"zip"];
        
        [newCardsInfo addObject:cardInfo];
        OI_RELEASE_SAFELY( cardInfo );
      }
    }
    
    if ( block ) {
      block( newCardsInfo );
    }
    
  }];
  
  [request setFailedBlock:^{
    block( [NSMutableArray array] );
  }];
  
  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES userAuthenticator:[userInfo createAuthenticatorWithUri:URLParams]];  
}

+ (void)loadCreditCardByNickname:(NSString *)nickname usingBlock:(void (^)(OICardInfo *cardInfo))block {
  OIUserInfo *userInfo = [OIUserInfo sharedInstance];
  NSString *URLParams = [NSString stringWithFormat:@"/u/%@/ccs/%@", userInfo.email.urlEncode, nickname.urlEncode];  
  NSString *URL = [NSString stringWithFormat:@"%@%@", OIUserBaseURL, URLParams];  
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];
  
  [request setCompletionBlock:^{    
    NSDictionary *json = [[request responseString] objectFromJSONString];    
    if( json ) {
      OICardInfo *cardInfo = [[[OICardInfo alloc] init] autorelease];
      cardInfo.nickname = nickname;
      cardInfo.name = [json objectForKey:@"name"];
      cardInfo.lastFiveDigits = [json objectForKey:@"cc_last5"];
      cardInfo.type = [json objectForKey:@"type"];
      cardInfo.expirationMonth = [json objectForKey:@"expiry_month"];
      cardInfo.expirationYear = [json objectForKey:@"expiry_year"];
      cardInfo.address.address1 =   [json objectForKey:@"addr"];
      cardInfo.address.address2 =   [json objectForKey:@"addr2"];
      cardInfo.address.city =   [json objectForKey:@"city"];
      cardInfo.address.state =   [json objectForKey:@"state"];
      cardInfo.address.postalCode =   [json objectForKey:@"zip"];
      
      if ( block ) {
        block( cardInfo );
      }
    }
    else
      block(nil);
  }];
  
  [request setFailedBlock:^{
    block(nil);
  }];
  
  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES userAuthenticator:[userInfo createAuthenticatorWithUri:URLParams]]; 
}

+ (void)deleteCreditCardByNickname:(NSString *)nickname usingBlock:(void (^)(NSError *error))block {
  OIUserInfo *userInfo = [OIUserInfo sharedInstance];  
  NSString *URLParams = [NSString stringWithFormat:@"/u/%@/ccs/%@",userInfo.email.urlEncode, nickname.urlEncode];  
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

@end

#pragma mark -
#pragma mark Private methods

@implementation OICardInfo (Private)
+ (ASIFormDataRequest *)createRequestForCreateOrUpdateActionWithCreditCard:(OICardInfo *)creditCard {
  OIUserInfo *userInfo = [OIUserInfo sharedInstance];
  NSString *URLParams = [NSString stringWithFormat:@"/u/%@/ccs/%@",userInfo.email.urlEncode, creditCard.nickname.urlEncode];  
  NSString *URL = [NSString stringWithFormat:@"%@%@", OIUserBaseURL, URLParams];
  
  ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:URL]];
  [request setRequestMethod:@"PUT"];
  
  [request setPostValue:creditCard.nickname forKey:@"nick"];
  [request setPostValue:creditCard.name forKey:@"name"];
  [request setPostValue:creditCard.number forKey:@"number"];
  [request setPostValue:creditCard.cvc forKey:@"cvc"];
  [request setPostValue:creditCard.expirationMonth forKey:@"expiry_month"];
  [request setPostValue:creditCard.expirationYear forKey:@"expiry_year"];
  [request setPostValue:creditCard.address.address1 forKey:@"bill_addr"];
  [request setPostValue:creditCard.address.address2 forKey:@"bill_addr2"];
  [request setPostValue:creditCard.address.city forKey:@"bill_city"];
  [request setPostValue:creditCard.address.state forKey:@"bill_state"];
  [request setPostValue:creditCard.address.postalCode forKey:@"bill_zip"];
  [request setPostValue:creditCard.address.phoneNumber forKey:@"phone"];
  
  return request;
}

@end

