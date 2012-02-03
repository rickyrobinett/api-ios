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
#import "OIRestaurant.h"
#import "OIAddress.h"
#import "OICommon.h"
#import "OICore.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "OIDelivery.h"

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
  BOOL __complete;
  NSString  *__id;
  NSString  *__name;
  NSString  *__phone;
  OIAddress *__address;
}

@synthesize complete  = __complete;
@synthesize id        = __id;
@synthesize name      = __name;
@synthesize phone     = __phone;
@synthesize address   = __address;

#pragma mark -
#pragma mark Properties

- (NSString *)description {
  return [NSString stringWithFormat:@"name: %@", __name];
}

#pragma mark -
#pragma mark Network

- (void)deliveryCheckToAddress:(OIAddress *)address atTime:(OIDateTime *)dateTime usingBlock:(void (^)(OIDelivery *delivery))block {
  NSString *URL = [NSString stringWithFormat:@"%@/dc/%@/%@%@", OIRestaurantBaseURL, __id, dateTime, address];
  
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

    if ( block ) {
      block(delivery);
    }
  }];

  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES];
}

- (void)downloadDetailUsingBlock:(void (^)(void))block {
  NSString *URL = [NSString stringWithFormat:@"%@/rd/%@", OIRestaurantBaseURL, __id];

  __block OIRestaurant *safe = self;
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];
  [request setCompletionBlock:^void() {
    NSDictionary *json = [[request responseString] objectFromJSONString];

    __complete = YES;
    safe.phone = [json objectForKey:@"cs_contact_phone"];
    safe.address = [OIAddress addressWithStreet:[json objectForKey:@"addr"]
                                           city:[json objectForKey:@"city"]
                                     postalCode:[json objectForKey:@"postal_code"]];

    if ( block ) {
      block();
    }
  }];

  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES];
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __id );
  OI_RELEASE_SAFELY( __name );
  OI_RELEASE_SAFELY( __phone );
  OI_RELEASE_SAFELY( __address );

  [super dealloc];
} 

#pragma mark -
#pragma mark Class methods

+ (void)restaurantsNearAddress:(OIAddress *)address availableAt:(OIDateTime *)dateTime usingBlock:(void (^)(NSArray *restaurants))block {
  NSString *URL = [NSString stringWithFormat:@"%@/dl/%@%@", OIRestaurantBaseURL, dateTime, address];

  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];
  [request setCompletionBlock:^void() {
    NSMutableArray *results = [NSMutableArray array];
    
    NSArray *json = [[request responseString] objectFromJSONString];
    for (NSDictionary *item in json) {
      OIRestaurant *restaurant = [[OIRestaurant alloc] init];
      restaurant.id = [item objectForKey:@"id"];
      restaurant.name = [item objectForKey:@"na"];

      [results addObject:restaurant];
      [restaurant release];
    }
    
    if ( block ) {
      block(results);
    }
  }];

  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES];
}

@end