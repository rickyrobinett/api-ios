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
NSString const* OIUserURL = @"https://u.ordr.in/";
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Implementation

@implementation OIUser {
@private
  NSString *__firstName;
  NSString *__lastName;
  NSMutableArray  *__addresses;
  NSMutableArray  *__creditCards;
  NSMutableArray  *__orders;
}

@synthesize firstName   = __firstName;
@synthesize lastName    = __lastName;
@synthesize addresses   = __addresses;
@synthesize creditCards = __creditCards;
@synthesize orders      = __orders;

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
        
    NSString *em = [json objectForKey:@"em"];
    NSString *pw = [json objectForKey:@"pw"];
    NSString *psswd = password;
    NSString *passwordSha256 = password.sha256;
    
    if ( [email isEqualToString:em] && [pw isEqualToString:passwordSha256] ) {
      OIUserInfo *userInfo = [OIUserInfo sharedInstance];
      userInfo.password = psswd;
      userInfo.email = [json objectForKey:@"em"];

      userInfo.firstName = user.firstName = [json objectForKey:@"first_name"];
      userInfo.lastName = user.lastName = [json objectForKey:@"last_name"];
      
      if ( blockUser ) {
        blockUser(user);
      }      
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

  [request setRequestMethod:@"POST"];
  
  NSString *passwordSha = password.sha256;
  [request setPostValue:email forKey:@"email"];  
  [request setPostValue:account.firstName forKey:@"first_name"];
  [request setPostValue:account.lastName forKey:@"last_name"];
  [request setPostValue:passwordSha forKey:@"pw"];
  
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

+ (void)updatePassword:(NSString *) password usingBlock:(void (^)(NSError *error))block {
  OIUserInfo *userInfo = [OIUserInfo sharedInstance];
  NSString *URLParams = [NSString stringWithFormat:@"/u/%@/password",userInfo.email.urlEncode];  
  NSString *URL = [NSString stringWithFormat:@"%@%@", OIUserBaseURL, URLParams];  

  __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:URL]];
  [request setRequestMethod:@"PUT"];
  [request setPostValue:userInfo.email forKey:@"email"];  
  [request setPostValue:password.sha256 forKey:@"password"];
  [request setPostValue:userInfo.password.sha256 forKey:@"previous_password"];
  
  [request setCompletionBlock:^{
    NSLog( @"%@", request.responseStatusMessage );
    userInfo.password = password;

    block( nil );
  }];
  
  [request setFailedBlock:^{
    block( [request error] );
  }];
  
  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES userAuthenticator:[userInfo createAuthenticatorWithUri:URLParams]]; 
}

@end

#pragma mark -
#pragma mark Address

@implementation OIUser (Address)

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

@end

#pragma mark -
#pragma mark CreditCard

@implementation OIUser (CreditCard)

- (void)initAllCreditCards {
  OI_RELEASE_SAFELY( __creditCards );
  [OICardInfo loadCreditCardsUsingBlock:^void( NSMutableArray *creditCards ) {
    __creditCards = [creditCards retain];
  }];
}

- (void)updateCreditCardAtIndex:(NSUInteger)index withCreditCard:(OICardInfo *)newCreditCard {
  OICardInfo *creditCard = [__creditCards objectAtIndex:index];
  [creditCard updateCreditCardWithCard:creditCard usingBlock:^(NSError *error) {
    if ( error ) {
      
    } else {
      
    }
  }];
}

- (void)addCreditCard:(OICardInfo *)creditCard {
  [OICardInfo addCreditCard:creditCard usingBlock:^( NSError *error ) {
    if ( error ) {
      
    } else {
      [__creditCards addObject:creditCard];
    }
  }];
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

@end

#pragma mark -
#pragma mark Order

@implementation OIUser (Order)

- (void)initOrderHistory {
  OI_RELEASE_SAFELY( __orders );
  [OIOrder loadOrderHistoryUsingBlock:^( NSMutableArray *orders ) {
    __orders = [orders retain];
  }];
}

@end
