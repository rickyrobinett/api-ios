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

#import "OIUser.h"
#import "OICore.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "OIAddress.h"
#import "OICardInfo.h"
#import "OIOrder.h"
#import "OIUserInfo.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Variables

NSString const* OIUserBaseURL = @"https://u-test.ordr.in";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Implementation

@implementation OIUser {
@private
  NSString *__firstName;
  NSString *__lastName;
  NSMutableArray  *__addresses;
  NSMutableArray  *__creditCards;
  NSArray  *__orders;
}

@synthesize firstName = __firstName;
@synthesize lastName  = __lastName;
@synthesize addresses = __addresses;
@synthesize creditCards = __creditCards;
@synthesize orders    = __orders;


#pragma mark -
#pragma mark Instance methods

- (void)initAllAddresses {
  OI_RELEASE_SAFELY( __addresses );

  [OIAddress loadAddressesUsingBlock:^void( NSMutableArray *addresses ) {    
    if ( addresses ) {
      __addresses = [addresses retain];
    }
  }];
}

- (void)updateAddressAtIndex:(NSUInteger)index withAddress:(OIAddress *)newAddress {
  OIAddress *address = [__addresses objectAtIndex:index];
  [address updateAddressWithAddress:newAddress usingBlock:^(NSError *error) {
    if ( error ) {
      
    } else {
      
    }
  }];
}

- (void)addAddress:(OIAddress *)address {
  [OIAddress addAddress:address usingBlock:^void( NSError *error ) {
    if ( error ) {
      
    } else {
      [__addresses addObject:address];
    }
  }];
}

- (void)deleteAddressByNickname:(NSString *)nickname {
  [OIAddress deleteAddressByNickname:nickname usingBlock:^(NSError *error) {
    if ( error ) {
      
    } else {
      for ( OIAddress *address in __addresses ) {
        if ( [nickname isEqualToString:address.nickname] ) {
          [__addresses removeObject:address];
        }
      }
    }
  }];
}

- (void)initAllCreditCards {
  OI_RELEASE_SAFELY( __creditCards );
  [OICardInfo loadCreditCardsUsingBlock:^void( NSMutableArray *creditCards ) {
    __creditCards = [creditCards retain];
  }];
}

- (void)addCreditCard:(OICardInfo *)creditCard {
  
}

- (void)addOrChangeCreditCard:(OICardInfo *)creditCard usingBlock:(void (^)(NSError *error))block {
  
//  NSString *URL = [NSString stringWithFormat:@"%@/u/%@/ccs/%@", OIUserBaseURL, [__email urlEncode], [[creditCard nickname] urlEncode]];
//  NSString *URLParams = [NSString stringWithFormat:@"u/%@/ccs/%@",[__email urlEncode], [[creditCard nickname] urlEncode]];
//  
//  __block OIUser *safe = self;
//  __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:URL]];
//  [request setRequestMethod:@"PUT"];
//  
//  [request setPostValue:__email forKey:@"email"];
//  [request setPostValue:[__password sha256] forKey:@"password"];
//  [request setPostValue:creditCard.nickname forKey:@"nick"];
//  [request setPostValue:creditCard.name forKey:@"name"];
//  [request setPostValue:creditCard.number forKey:@"number"];
//  [request setPostValue:creditCard.cvc forKey:@"cvc"];
//  [request setPostValue:creditCard.expirationMonth forKey:@"expiry_month"];
//  [request setPostValue:creditCard.expirationYear forKey:@"expiry_year"];
//  [request setPostValue:creditCard.address.address1 forKey:@"bill_addr"];
//  [request setPostValue:creditCard.address.address2 forKey:@"bill_addr2"];
//  [request setPostValue:creditCard.address.city forKey:@"bill_city"];
//  [request setPostValue:creditCard.address.state forKey:@"bill_state"];
//  [request setPostValue:creditCard.address.postalCode forKey:@"bill_zip"];
//  [request setPostValue:creditCard.address.phoneNumber forKey:@"phone"];
//  
//  [request setCompletionBlock:^{
//    
//#warning Handle error returned by server: _error	a boolean (0|1), 1 means there was an error, 0 means it was successful
//    
//    OICardInfo *item;
//    for (item in safe.creditCards) {
//      
//      if([creditCard.nickname isEqualToString:[item nickname]]) {
//        [item copy:creditCard];
//      }
//    }
//    
//    block(nil);
//  }];
//  
//  [request setFailedBlock:^{
//    block([request error]);
//  }];
//  
//  OIAPIClient *client = [OIAPIClient sharedInstance];
//  [client appendRequest:request authorized:YES userAuthenticator:[OIAPIUserAuthenticator authenticatorWithEmail:__email password:__password uri:[NSURL URLWithString:URLParams]]];  
  
}

- (void)deleteCreditCardByNickname:(NSString *)nickname {
  [OICardInfo deleteCreditCardByNickname:nickname usingBlock:^( NSError *error ) {
    if ( error ) {
      
    } else {
      for ( OICardInfo *creditCard in __creditCards ) {
        if ( [creditCard.nickname isEqualToString:creditCard.nickname] ) {
          [__creditCards removeObject:creditCard];
        }
      }
    }
  }];
}

- (void)loadOrderHistoryUsingBlock:(void (^)(NSError *error))block {
  
//  NSString *URL = [NSString stringWithFormat:@"%@/u/%@/orders", OIUserBaseURL, [__email urlEncode]];
//  NSString *URLParams = [NSString stringWithFormat:@"u/%@/orders",[__email urlEncode]];
//  
//  __block OIUser *safe = self;
//  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];
//  
//  [request setCompletionBlock:^{
//    
//    [safe.creditCards release];
//    
//    NSDictionary *json = [[request responseString] objectFromJSONString];
//    NSArray *allKeys = [json allKeys];
//    
//    NSString *item;
//    
//    NSMutableArray *newOrders = [[[NSMutableArray alloc] init] autorelease];
//    
//    for (item in allKeys) {
//      
//      NSDictionary *orderDict = [json objectForKey:item];
//      
//      if(orderDict) {
//        OIOrder *order = [[[OIOrder alloc] init] autorelease];
//        
//#warning Fill order instance
//        
//        [newOrders addObject:order];
//      }
//    }
//    
//    safe.orders = [NSArray arrayWithArray:newOrders];
//    
//    if ( block ) {
//      block(nil);
//    }
//    
//  }];
//  
//  [request setFailedBlock:^{
//    block([request error]);
//  }];
//  
//  OIAPIClient *client = [OIAPIClient sharedInstance];
//  [client appendRequest:request authorized:YES userAuthenticator:[OIAPIUserAuthenticator authenticatorWithEmail:__email password:__password uri:[NSURL URLWithString:URLParams]]]; 
}

- (void)loadOrderByID:(NSString *)ID usingBlock:(void (^)(OIOrder *order))block {
//  
//  NSString *URL = [NSString stringWithFormat:@"%@/u/%@/order/%@", OIUserBaseURL, [__email urlEncode], [ID urlEncode]];
//  NSString *URLParams = [NSString stringWithFormat:@"u/%@/order/%@",[__email urlEncode], [ID urlEncode]];
//  
//  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];
//  
//  [request setCompletionBlock:^{
//    
//    NSDictionary *json = [[request responseString] objectFromJSONString];
//    
//    if(json)
//    {
//      OIOrder *order = [[[OIOrder alloc] init] autorelease];
//      
//#warning Fill order instance
//      
//      if ( block ) {
//        block(order);
//      }
//    }
//    else
//      block(nil);
//  }];
//  
//  [request setFailedBlock:^{
//    block(nil);
//  }];
//  
//  OIAPIClient *client = [OIAPIClient sharedInstance];
//  [client appendRequest:request authorized:YES userAuthenticator:[OIAPIUserAuthenticator authenticatorWithEmail:__email password:__password uri:[NSURL URLWithString:URLParams]]];
//  
}

- (void)updatePassword:(NSString *) password usingBlock:(void (^)(NSError *error))block {
  
//  NSString *URL = [NSString stringWithFormat:@"%@/u/%@/password", OIUserBaseURL, [__email urlEncode]];
//  NSString *URLParams = [NSString stringWithFormat:@"u/%@/password",[__email urlEncode]];
//  
//  __block OIUser *safe = self;
//  __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:URL]];
//  [request setRequestMethod:@"PUT"];
//  
//  [request setPostValue:[password sha256] forKey:@"password"];
//  
//  [request setCompletionBlock:^{
//    
//    safe.password = password;
//    
//#warning Handle error returned by server: _error	a boolean (0|1), 1 means there was an error, 0 means it was successful
//    
//    block(nil);
//  }];
//  
//  [request setFailedBlock:^{
//    block([request error]);
//  }];
//  
//  OIAPIClient *client = [OIAPIClient sharedInstance];
//  [client appendRequest:request authorized:YES userAuthenticator:[OIAPIUserAuthenticator authenticatorWithEmail:__email password:__password uri:[NSURL URLWithString:URLParams]]]; 
}


#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __firstName );
  OI_RELEASE_SAFELY( __lastName );
  OI_RELEASE_SAFELY( __addresses );
  OI_RELEASE_SAFELY( __creditCards );
  OI_RELEASE_SAFELY( __orders );
  
  [super dealloc];
}

#pragma mark -
#pragma mark Class methods

+ (void)accountInfo:(NSString *)email password:(NSString *)password usingBlockUser:(void (^)(OIUser *user))blockUser usingBlockError:(void (^)(NSError *error))blockError; {
  NSString *URLParams = [NSString stringWithFormat:@"/u/%@/",[email urlEncode]];
  NSString *URL = [NSString stringWithFormat:@"%@%@", OIUserBaseURL, URLParams];
  
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];
  
  [request setCompletionBlock:^{
    
    NSDictionary *json = [[request responseString] objectFromJSONString];
    OIUser *user = [[[OIUser alloc] init] autorelease];
    
//    OIUserInfo *userInfo = [OIUserInfo sharedInstance];
//    userInfo.password = password;
//    userInfo.email = [json objectForKey:@"em"];
    
    user.firstName = [json objectForKey:@"first_name"];
    user.lastName = [json objectForKey:@"last_name"];
    
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

+ (void)createNewAccount:(OIUser *)account email:(NSString *)email password:(NSString *)password usingBlock:(void (^)(NSError *error))block {
  NSString *URL = [NSString stringWithFormat:@"%@/u/%@", OIUserBaseURL, [email urlEncode]];
  
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

+ (OIUser *)userWithFirstName:(NSString *)firstName lastName:(NSString *)lastName {
  OIUser *user = [[OIUser alloc] init];
  user.firstName = firstName;
  user.lastName = lastName;

  return [user autorelease];
}

@end
