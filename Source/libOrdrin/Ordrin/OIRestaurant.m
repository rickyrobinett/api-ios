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
#import "OIRestaurantAddress.h"
#import "OICommon.h"
#import "OICore.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"

NSString *const OIRestaurantBaseURL = @"https://r-test.ordr.in";

@implementation OIRestaurant {
@private
  NSString *__id;
  NSString *__name;
  NSString *__address;
}

@synthesize id      = __id;
@synthesize name    = __name;
@synthesize address = __address;

#pragma mark -
#pragma mark Properties

- (NSString *)description {
  return [NSString stringWithFormat:@"name: %@", __name];
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __id );
  OI_RELEASE_SAFELY( __name );
  OI_RELEASE_SAFELY( __address );
  
  [super dealloc];
} 

#pragma mark -
#pragma mark Class methods

+ (void)restaurantsNearAddress:(OIRestaurantAddress *)address availableAt:(OIDateTime *)dateTime usingBlock:(void (^)(NSArray *restaurants))block {
  NSString *URL = [NSString stringWithFormat:@"%@/dl/%@%@", OIRestaurantBaseURL, dateTime, address];

  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];
  [request setCompletionBlock:^void() {
    NSMutableArray *results = [NSMutableArray array];
    
    NSArray *json = [[request responseString] objectFromJSONString];
    for (NSDictionary *item in json) {
      OIRestaurant *restaurant = [[OIRestaurant alloc] init];
      restaurant.id = [item objectForKey:@"id"];
      restaurant.name = [item objectForKey:@"na"];
      restaurant.address = [item objectForKey:@"ad"];

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