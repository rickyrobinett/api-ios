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
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "OIAddress.h"
#import "OICardInfo.h"
#import "OIOrder.h"

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
  OI_RELEASE_SAFELY( __addresses );

  NSString *URL = [NSString stringWithFormat:@"%@/u/%@/addrs", OIUserBaseURL, [__email urlEncode]];
  NSString *URLParams = [NSString stringWithFormat:@"u/%@/addrs",[__email urlEncode]];
  
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];

  [request setCompletionBlock:^{
    
    NSDictionary *json = [[request responseString] objectFromJSONString];
    NSArray *allKeys = [json allKeys];
    
    NSString *item;
    
    NSMutableArray *newAddresses = [[NSMutableArray alloc] init];
    
    for (item in allKeys) {
      
      NSDictionary *addressDict = [json objectForKey:item];
      
      if(addressDict) {
        OIAddress *address = [[[OIAddress alloc] init] autorelease];
        address.nickname = item;
        address.address1 =   [addressDict objectForKey:@"addr"];
        address.address2 =   [addressDict objectForKey:@"addr2"];
        address.city =   [addressDict objectForKey:@"city"];
        address.state =   [addressDict objectForKey:@"state"];
        address.postalCode =   [addressDict objectForKey:@"zip"];
        address.phoneNumber =   [addressDict objectForKey:@"phone"];
        [newAddresses addObject:address];
      }
    }
    
    self.addresses = [NSArray arrayWithArray:newAddresses];
    [newAddresses release];
    
    if ( block ) {
      block(nil);
    }
    
  }];
  
  [request setFailedBlock:^{
    block([request error]);
  }];
  
  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES userAuthenticator:[OIAPIUserAuthenticator authenticatorWithEmail:__email password:__password uri:[NSURL URLWithString:URLParams]]];
}

- (void)loadAddressByNickname:(NSString *)nickname usingBlock:(void (^)(OIAddress *address))block {
  
  NSString *URL = [NSString stringWithFormat:@"%@/u/%@/addrs/%@", OIUserBaseURL, [__email urlEncode], [nickname urlEncode]];
  NSString *URLParams = [NSString stringWithFormat:@"u/%@/addrs/%@",[__email urlEncode], [nickname urlEncode]];
  
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];
  
  [request setCompletionBlock:^{
    
    NSDictionary *json = [[request responseString] objectFromJSONString];
    
    if(json)
    {
      OIAddress *address = [[[OIAddress alloc] init] autorelease];
      address.nickname = nickname;
      address.address1 =   [json objectForKey:@"addr"];
      address.address2 =   [json objectForKey:@"addr2"];
      address.city =   [json objectForKey:@"city"];
      address.state =   [json objectForKey:@"state"];
      address.postalCode =   [json objectForKey:@"zip"];
      address.phoneNumber =   [json objectForKey:@"phone"];   
      
      if ( block ) {
        block(address);
      }
    }
    else
      block(nil);
  }];
  
  [request setFailedBlock:^{
    block(nil);
  }];
  
  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES userAuthenticator:[OIAPIUserAuthenticator authenticatorWithEmail:__email password:__password uri:[NSURL URLWithString:URLParams]]];
}

- (void)addOrChangeAddress:(OIAddress *)address usingBlock:(void (^)(NSError *error))block {
  
  NSString *URL = [NSString stringWithFormat:@"%@/u/%@/addrs/%@", OIUserBaseURL, [__email urlEncode], [[address nickname] urlEncode]];
  NSString *URLParams = [NSString stringWithFormat:@"u/%@/addrs/%@",[__email urlEncode], [[address nickname] urlEncode]];
  
  __block OIUser *safe = self;
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
    
    // TODO: Handle error returned by server: _error	a boolean (0|1), 1 means there was an error, 0 means it was successful
    
    OIAddress *item;
    for (item in safe.addresses) {
      
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

- (void)deleteAddressByNickname:(NSString *)nickname usingBlock:(void (^)(NSError *error))block {
  
  NSString *URL = [NSString stringWithFormat:@"%@/u/%@/addrs/%@", OIUserBaseURL, [__email urlEncode], [nickname urlEncode]];
  NSString *URLParams = [NSString stringWithFormat:@"u/%@/addrs/%@",[__email urlEncode], [nickname urlEncode]];
  
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];
  [request setRequestMethod:@"DELETE"];
  
  [request setCompletionBlock:^{
    
    // TODO: Handle error returned by server: _error	a boolean (0|1), 1 means there was an error, 0 means it was successful
    // TODO: Remove Address from OIUser instance
    block(nil);
  }];
  
  [request setFailedBlock:^{
    block([request error]);
  }]; 
  
  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES userAuthenticator:[OIAPIUserAuthenticator authenticatorWithEmail:__email password:__password uri:[NSURL URLWithString:URLParams]]];
}

- (void)loadCreditCardsUsingBlock:(void (^)(NSError *error))block {
  
  NSString *URL = [NSString stringWithFormat:@"%@/u/%@/ccs", OIUserBaseURL, [__email urlEncode]];
  NSString *URLParams = [NSString stringWithFormat:@"u/%@/ccs",[__email urlEncode]];
  
  __block OIUser *safe = self;
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];
  
  [request setCompletionBlock:^{
    
    [safe.creditCards release];
    
    NSDictionary *json = [[request responseString] objectFromJSONString];
    NSArray *allKeys = [json allKeys];
    
    NSString *item;
    
    NSMutableArray *newCardsInfo = [[[NSMutableArray alloc] init] autorelease];
    
    for (item in allKeys) {
      
      NSDictionary *cardInfoDict = [json objectForKey:item];
      
      if(cardInfoDict) {
        OICardInfo *cardInfo = [[[OICardInfo alloc] init] autorelease];
        
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
      }
    }
    
    safe.creditCards = [NSArray arrayWithArray:newCardsInfo];
    
    if ( block ) {
      block(nil);
    }
    
  }];
  
  [request setFailedBlock:^{
    block([request error]);
  }];
  
  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES userAuthenticator:[OIAPIUserAuthenticator authenticatorWithEmail:__email password:__password uri:[NSURL URLWithString:URLParams]]];
}

- (void)loadCreditCardByNickname:(NSString *)nickname usingBlock:(void (^)(OICardInfo *cardInfo))block {
  
  NSString *URL = [NSString stringWithFormat:@"%@/u/%@/ccs/%@", OIUserBaseURL, [__email urlEncode], [nickname urlEncode]];
  NSString *URLParams = [NSString stringWithFormat:@"u/%@/ccs/%@",[__email urlEncode], [nickname urlEncode]];
  
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];
  
  [request setCompletionBlock:^{
    
    NSDictionary *json = [[request responseString] objectFromJSONString];
    
    if(json)
    {
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
        block(cardInfo);
      }
    }
    else
      block(nil);
  }];
  
  [request setFailedBlock:^{
    block(nil);
  }];
  
  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES userAuthenticator:[OIAPIUserAuthenticator authenticatorWithEmail:__email password:__password uri:[NSURL URLWithString:URLParams]]]; 
}

- (void)addOrChangeCreditCard:(OICardInfo *)creditCard usingBlock:(void (^)(NSError *error))block {
  
  NSString *URL = [NSString stringWithFormat:@"%@/u/%@/ccs/%@", OIUserBaseURL, [__email urlEncode], [[creditCard nickname] urlEncode]];
  NSString *URLParams = [NSString stringWithFormat:@"u/%@/ccs/%@",[__email urlEncode], [[creditCard nickname] urlEncode]];
  
  __block OIUser *safe = self;
  __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:URL]];
  [request setRequestMethod:@"PUT"];
  
  [request setPostValue:__email forKey:@"email"];
  [request setPostValue:[__password sha256] forKey:@"password"];
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
  
  [request setCompletionBlock:^{
    
    // TODO: Handle error returned by server: _error	a boolean (0|1), 1 means there was an error, 0 means it was successful
    
    OICardInfo *item;
    for (item in safe.creditCards) {
      
      if([creditCard.nickname isEqualToString:[item nickname]]) {
        [item copy:creditCard];
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

- (void)deleteCreditCardByNickname:(NSString *)nickname usingBlock:(void (^)(NSError *error))block {
  
  NSString *URL = [NSString stringWithFormat:@"%@/u/%@/ccs/%@", OIUserBaseURL, [__email urlEncode], [nickname urlEncode]];
  NSString *URLParams = [NSString stringWithFormat:@"u/%@/ccs/%@",[__email urlEncode], [nickname urlEncode]];
  
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];
  [request setRequestMethod:@"DELETE"];
  
  [request setCompletionBlock:^{
    
    // TODO: Handle error returned by server: _error	a boolean (0|1), 1 means there was an error, 0 means it was successful
    // TODO: Remove CardInfo from OIUser instance
    block(nil);
  }];
  
  [request setFailedBlock:^{
    block([request error]);
  }]; 
  
  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES userAuthenticator:[OIAPIUserAuthenticator authenticatorWithEmail:__email password:__password uri:[NSURL URLWithString:URLParams]]]; 
}

- (void)loadOrderHistoryUsingBlock:(void (^)(NSError *error))block {
  
  NSString *URL = [NSString stringWithFormat:@"%@/u/%@/orders", OIUserBaseURL, [__email urlEncode]];
  NSString *URLParams = [NSString stringWithFormat:@"u/%@/orders",[__email urlEncode]];
  
  __block OIUser *safe = self;
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];
  
  [request setCompletionBlock:^{
    
    [safe.creditCards release];
    
    NSDictionary *json = [[request responseString] objectFromJSONString];
    NSArray *allKeys = [json allKeys];
    
    NSString *item;
    
    NSMutableArray *newOrders = [[[NSMutableArray alloc] init] autorelease];
    
    for (item in allKeys) {
      
      NSDictionary *orderDict = [json objectForKey:item];
      
      if(orderDict) {
        OIOrder *order = [[[OIOrder alloc] init] autorelease];
        
        //TODO: Fill order instance
        
        [newOrders addObject:order];
      }
    }
    
    safe.orders = [NSArray arrayWithArray:newOrders];
    
    if ( block ) {
      block(nil);
    }
    
  }];
  
  [request setFailedBlock:^{
    block([request error]);
  }];
  
  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES userAuthenticator:[OIAPIUserAuthenticator authenticatorWithEmail:__email password:__password uri:[NSURL URLWithString:URLParams]]]; 
}

- (void)loadOrderByID:(NSString *)ID usingBlock:(void (^)(OIOrder *order))block {
  
  NSString *URL = [NSString stringWithFormat:@"%@/u/%@/order/%@", OIUserBaseURL, [__email urlEncode], [ID urlEncode]];
  NSString *URLParams = [NSString stringWithFormat:@"u/%@/order/%@",[__email urlEncode], [ID urlEncode]];
  
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];
  
  [request setCompletionBlock:^{
    
    NSDictionary *json = [[request responseString] objectFromJSONString];
    
    if(json)
    {
      OIOrder *order = [[[OIOrder alloc] init] autorelease];
      
      // TODO: Fill order instance
      
      if ( block ) {
        block(order);
      }
    }
    else
      block(nil);
  }];
  
  [request setFailedBlock:^{
    block(nil);
  }];
  
  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES userAuthenticator:[OIAPIUserAuthenticator authenticatorWithEmail:__email password:__password uri:[NSURL URLWithString:URLParams]]];
  
}

- (void)updatePassword:(NSString *) password usingBlock:(void (^)(NSError *error))block {
  
  NSString *URL = [NSString stringWithFormat:@"%@/u/%@/password", OIUserBaseURL, [__email urlEncode]];
  NSString *URLParams = [NSString stringWithFormat:@"u/%@/password",[__email urlEncode]];
  
  __block OIUser *safe = self;
  __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:URL]];
  [request setRequestMethod:@"PUT"];
  
  [request setPostValue:[password sha256] forKey:@"password"];
  
  [request setCompletionBlock:^{
    
    safe.password = password;
    
    // TODO: Handle error returned by server: _error	a boolean (0|1), 1 means there was an error, 0 means it was successful
    
    block(nil);
  }];
  
  [request setFailedBlock:^{
    block([request error]);
  }];
  
  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES userAuthenticator:[OIAPIUserAuthenticator authenticatorWithEmail:__email password:__password uri:[NSURL URLWithString:URLParams]]]; 
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
  OI_RELEASE_SAFELY( __orders );
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
