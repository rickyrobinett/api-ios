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

#import "OIOrder.h"
#import "OICore.h"
#import "OIAddress.h"
#import "OICardInfo.h"
#import "OIUser.h"
#import "ASIFormDataRequest.h"
#import "OIRestaurantBase.h"
#import "JSONKit.h"
#import "OIUserInfo.h"
#import "OIOrderItem.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Variables

NSString *const OIOrderBaseURL = @"https://o-test.ordr.in";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Implementation

@interface OIOrder (Private)
+ (OIOrder *)createOrderFromDictionary:(NSDictionary *)orderDict;
@end

@implementation OIOrder {
@private
  NSString          *__orderID;
  NSNumber          *__total;
  NSNumber          *__tip;
  NSDate            *__date;
  NSArray           *__items;
  OIRestaurantBase  *__restaurantBase;
}

@synthesize orderID        = __orderID;
@synthesize total          = __total;
@synthesize tip            = __tip;
@synthesize date           = __date;
@synthesize items          = __items;
@synthesize restaurantBase = __restaurantBase;

#pragma mark -
#pragma mark Properties

- (NSString *)description {
  return [NSString stringWithFormat:@"orderId: %@\ntotal: %d\ntip: %d\ndate: %@\nitems: %@\nrestaurant: %@", __orderID, __total.intValue, __tip.intValue, __date, __items, __restaurantBase.description];
}

#pragma mark -
#pragma mark Instance methods

- (void)orderForUser:(OIUser *)user atAddress:(OIAddress*)address withCard:(OICardInfo *)card usingBlock:(void (^)(NSError *error))block {
  OIUserInfo *userInfo = [OIUserInfo sharedInstance];
  NSString *URL = [NSString stringWithFormat:@"%@/o/%@", OIOrderBaseURL, __restaurantBase.ID];
  
  __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:URL]];
  
  [request setPostValue:@"3270/2+3263/1,3279" forKey:@"tray"];
  [request setPostValue:@"20" forKey:@"tip"];
  [request setPostValue:@"01-21" forKey:@"delivery_date"];
  [request setPostValue:@"21:30" forKey:@"delivery_time"];
  [request setPostValue:@"daniel" forKey:@"first_name"];
  [request setPostValue:@"krezelok" forKey:@"last_name"];
  [request setPostValue:@"konska 497" forKey:@"addr"];
  [request setPostValue:@"Trinec" forKey:@"city"];
  [request setPostValue:@"FL" forKey:@"state"];
  [request setPostValue:@"73961" forKey:@"zip"];
  [request setPostValue:@"111-222-3333" forKey:@"phone"];
  [request setPostValue:userInfo.email forKey:@"em"];
  [request setPostValue:userInfo.password.sha256 forKey:@"password"];
  [request setPostValue:@"Master" forKey:@"card_name"];
  [request setPostValue:@"5210669468946428" forKey:@"card_number"];
  [request setPostValue:@"651" forKey:@"card_cvc"];
  [request setPostValue:@"12/2013" forKey:@"card_expiry"];
  [request setPostValue:@"adresa1" forKey:@"card_bill_addr"];
  [request setPostValue:@"adresa2" forKey:@"card_bill_addr2"];
  [request setPostValue:@"Trinec" forKey:@"card_bill_city"];
  [request setPostValue:@"FL" forKey:@"card_bill_state"];
  [request setPostValue:@"73961" forKey:@"card_bill_zip"];  
  
  [request setCompletionBlock:^{
    NSDictionary *json = [[request responseString] objectFromJSONString];
    NSLog( @"%@", json );
    if ( block ) {
      block( nil );
    }
  }];
  
  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES];
}

- (NSNumber *)calculateSubtotal {
#warning Define body
  return nil;
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __orderID );
  OI_RELEASE_SAFELY( __total );
  OI_RELEASE_SAFELY( __tip );
  OI_RELEASE_SAFELY( __date );
  OI_RELEASE_SAFELY( __items );
  OI_RELEASE_SAFELY( __restaurantBase );
  
  [super dealloc];
}

#pragma mark -
#pragma mark Class methods

+ (void)loadOrderHistoryUsingBlock:(void (^)(NSMutableArray *orders))block {
  OIUserInfo *userInfo = [OIUserInfo sharedInstance];
  NSString *URLParams = [NSString stringWithFormat:@"/u/%@/orders",userInfo.email.urlEncode];
  NSString *URL = [NSString stringWithFormat:@"%@%@", OIUserBaseURL, URLParams];
    
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];
  
  [request setCompletionBlock:^{        
    NSDictionary *json = [[request responseString] objectFromJSONString];
    NSArray *allKeys = [json allKeys];    
    NSString *item;
    
    NSMutableArray *newOrders = [NSMutableArray array];
    
    for (item in allKeys) {      
      NSDictionary *orderDict = [json objectForKey:item];      
      if( orderDict ) {
        OIOrder *order = [OIOrder createOrderFromDictionary:orderDict];
        [newOrders addObject:order];
      }
    }    
    if ( block ) {
      block( newOrders );
    }    
  }];
  
  [request setFailedBlock:^{
    block( [NSMutableArray array] );
  }];
  
  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES userAuthenticator:[userInfo createAuthenticatorWithUri:URLParams]]; 
}

+ (void)loadOrderByID:(NSString *)ID usingBlock:(void (^)(OIOrder *order))block {
  OIUserInfo *userInfo = [OIUserInfo sharedInstance];  
  NSString *URLParams = [NSString stringWithFormat:@"/u/%@/order/%@", userInfo.email.urlEncode, ID.urlEncode];
  
  NSString *URL = [NSString stringWithFormat:@"%@%@", OIUserBaseURL, URLParams];  
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];
  
  [request setCompletionBlock:^{    
    NSDictionary *json = [[request responseString] objectFromJSONString];    
    if( json ) {
      OIOrder *order = [OIOrder createOrderFromDictionary:json];      
      if ( block ) {
        block( order );
      }
    }
    else {
      block( nil );      
    }
  }];
  
  [request setFailedBlock:^{
    block( nil );
  }];
  
  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES userAuthenticator:[userInfo createAuthenticatorWithUri:URLParams]]; 
}

@end

#pragma mark -
#pragma mark Private methods

@implementation OIOrder (Private)

+ (OIOrder *)createOrderFromDictionary:(NSDictionary *)orderDict {
  OIOrder *order = [[[OIOrder alloc] init] autorelease];
  OIRestaurantBase *restaurantBase = [[OIRestaurantBase alloc] init];        
  
  order.orderID = [orderDict objectForKey:@"oid"];
  order.total = [orderDict objectForKey:@"total"];
  order.tip = [orderDict objectForKey:@"tip"];
  order.date = [orderDict objectForKey:@"ctime"];
  
  restaurantBase.ID = [orderDict objectForKey:@"rid"];
  restaurantBase.name = [orderDict objectForKey:@"rname"];
  
  order.restaurantBase = restaurantBase;
  
  NSDictionary *itemsDict = [orderDict objectForKey:@"item"];        
  NSArray *allKeys = itemsDict.allKeys;
  
  for ( NSString *key in allKeys ) {
    NSDictionary *itemDict = [itemsDict objectForKey:key];
    
    OIOrderItem *orderItem = [[OIOrderItem alloc] init];
    orderItem.ID = [itemDict objectForKey:@"id"];
    orderItem.name = [itemDict objectForKey:@"name"];
    orderItem.price = [itemDict objectForKey:@"price"];
    orderItem.quantity = [itemDict objectForKey:@"qty"];
    
//          NSDictionary *opts = [itemDict objectForKey:@"opts"];
//          NSArray *optsKeys = opts.allKeys;
    
#warning Docist opts polozky v OIOrder          
//          for ( NSString *key in optsKeys ) {
//            NSDictionary *optsDict = [opts objectForKey:key];
//            
//          }
    OI_RELEASE_SAFELY( orderItem );
  }    
  OI_RELEASE_SAFELY( restaurantBase );

  return order;
}

@end


