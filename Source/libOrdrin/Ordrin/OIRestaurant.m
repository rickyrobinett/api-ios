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

#import "OIRestaurant.h"
#import "OIAddress.h"
#import "OICommon.h"
#import "OICore.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "OIDelivery.h"
#import "OIRDSInfo.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Variables

NSString *const OIRestaurantBaseURL = @"https://r-test.ordr.in";

static inline NSDate* OIDateTimeSinceNowWithMinutes(NSInteger minutes) {
  return [NSDate dateWithTimeInterval:minutes*60 sinceDate:[NSDate date]];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Implementation

@implementation OIRestaurant {
@private
  OIAddress    *__address;
  NSString     *__phone;
  NSString     *__state;
  NSDictionary *__meals;
  NSDictionary *__menu;
  OIRDSInfo    *__rdsInfo;
}

@synthesize address   = __address;
@synthesize phone     = __phone;
@synthesize state     = __state;
@synthesize meals     = __meals;
@synthesize menu      = __menu;
@synthesize rdsInfo   = __rdsInfo;

#pragma mark -
#pragma mark Initializations

- (id)initWithRestaurantBase:(OIRestaurantBase *)restaurantBase {
  self = [super initWithRestaurantBase:restaurantBase];  
  if ( self ) {    
  }
  
  return self;
}

#pragma mark -
#pragma mark Properties

- (NSString *)description {
  return [NSString stringWithFormat:@"address: %@\nphone: %@\nstate: %@\nmeals: %@\nrdsInfo: %@", __address, __phone, __state, __meals, __menu, __rdsInfo];
}

#pragma mark -
#pragma mark Instance methods

- (void)deliveryCheckToAddress:(OIAddress *)address atTime:(OIDateTime *)dateTime usingBlock:(void (^)(OIDelivery *delivery))block {
  NSString *URL = [NSString stringWithFormat:@"%@/dc/%@/%@%@", OIRestaurantBaseURL, self.ID, dateTime, address.addressAsString];
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];
  [request setCompletionBlock:^void() {
    NSDictionary *json = [[request responseString] objectFromJSONString];

    OIDelivery *delivery = [[[OIDelivery alloc] init] autorelease];
    delivery.available = [[json objectForKey:@"delivery"] boolValue];
    if ( !delivery.available ) {
      delivery.message = [json objectForKey:@"msg"];
    }

    delivery.minimumAmount = [json objectForKey:@"mino"];
    delivery.expectedTime = OIDateTimeSinceNowWithMinutes([[json objectForKey:@"del"] integerValue]);
    delivery.meals = [[json objectForKey:@"meals"] allValues];
    delivery.ID = [json objectForKey:@"rid"];
      
    if ( block ) {
      block(delivery);
    }
  }];

  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES];
}

- (void)calculateFeesForSubtotal:(OIOrder *)order usingBlock:(void (^)(OIDelivery *delivery))block {
  
#warning Initialize all data to retrieve valid request string
  OIAddress *address = (OIAddress*)[order address];
  NSNumber *subtotal = nil;
  NSNumber *tip = nil;
    
  NSString *URL = [NSString stringWithFormat:@"%@/fee/%@/%@/%@", OIRestaurantBaseURL, self.ID, subtotal, tip, address]; 
  
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];
  [request setCompletionBlock:^void() {
    NSDictionary *json = [[request responseString] objectFromJSONString];        
    OIDelivery *delivery = [[[OIDelivery alloc] init] autorelease];        
    delivery.available = [[json objectForKey:@"delivery"] boolValue];
  
    if ( ! [delivery isAvailable] ) { 
      delivery.message = [json objectForKey:@"msg"];
    }
        
    delivery.minimumAmount = [json objectForKey:@"mino"];
    delivery.expectedTime = OIDateTimeSinceNowWithMinutes([[json objectForKey:@"del"] integerValue]);
    delivery.meals = [[json objectForKey:@"meals"] allValues];
    delivery.ID = [json objectForKey:@"rid"];
    delivery.fee = [json objectForKey:@"fee"];
    delivery.tax = [json objectForKey:@"tax"];
      
    if ( block ) {
      block(delivery);
    }
  }];
    
  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES];
}

- (NSArray *)menuItemsForChildrens:(NSArray *) childrenIDs {
    
    return [NSArray arrayWithObjects:nil];
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __address );
  OI_RELEASE_SAFELY( __phone );  
  OI_RELEASE_SAFELY( __state );
  OI_RELEASE_SAFELY( __meals );
  OI_RELEASE_SAFELY( __menu );
  OI_RELEASE_SAFELY( __rdsInfo );
  
  [super dealloc];
} 

#pragma mark -
#pragma mark Class methods

+ (void)createRestaurantByRestaurantBase:(OIRestaurantBase *)restaurantBase usingBlock:(void (^)(OIRestaurant *restaurant))block {
  NSString *URL = [NSString stringWithFormat:@"%@/rd/%@", OIRestaurantBaseURL, restaurantBase.ID];
  
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];  
  [request setCompletionBlock:^void() {
    NSDictionary *json = [[request responseString] objectFromJSONString];
    
    OIRestaurant *restaurant = [[[OIRestaurant alloc] initWithRestaurantBase:restaurantBase] autorelease];
    
    restaurant.phone = [json objectForKey:@"cs_contact_phone"];
    restaurant.address = [OIAddress addressWithStreet:[json objectForKey:@"addr"]
                                             city:[json objectForKey:@"city"]
                                       postalCode:[json objectForKey:@"postal_code"]];
        
    restaurant.state = [json objectForKey:@"state"];
    restaurant.meals = [json objectForKey:@"meal_name"];
    restaurant.menu = [json objectForKey:@"menu"]; 
        
    if ( block ) {
      block(restaurant);
    }
  }];
      
  OIAPIClient *client = [OIAPIClient sharedInstance];  
  [client appendRequest:request authorized:YES];    
}

@end