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
 *      Daniel Krezelok (daniel.krezelok@tapmates.com)
 */

#import "OIRestaurantBase.h"
#import "OICore.h"
#import "OIRestaurant.h"
#import "OIAddress.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Implementation

@implementation OIRestaurantBase {
@private
  BOOL __complete;
  NSString     *__id;
  NSString     *__name;
}

@synthesize ID        = __id;
@synthesize name      = __name;

#pragma mark -
#pragma mark Initializations

- (id)initWithRestaurantBase:(OIRestaurantBase *)restaurantBase {
  self = [super init];
  
  if ( self ) {
    __id = [restaurantBase.ID retain];
    __name = [restaurantBase.name retain];
  }
  
  return self;
}

#pragma mark -
#pragma mark Properties

- (NSString *)description {
  return [NSString stringWithFormat:@"id: %@\nname: %@", __id, __name];
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  OI_RELEASE_SAFELY( __id );
  OI_RELEASE_SAFELY( __name );
  
  [super dealloc];
}

#pragma mark -
#pragma mark Class methods

#warning Upravit dle potreb
+ (void)restaurantsNearAddress:(OIAddress *)address availableAt:(OIDateTime *)dateTime usingBlock:(void (^)(NSArray *restaurants))block {
  NSString *URL = [NSString stringWithFormat:@"%@/dl/%@%@", OIRestaurantBaseURL, dateTime, address];
  
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];
  [request setCompletionBlock:^void() {
    NSMutableArray *results = [NSMutableArray array];
    
    NSArray *json = [[request responseString] objectFromJSONString];
    for (NSDictionary *item in json) {
      OIRestaurantBase *restaurant = [[OIRestaurantBase alloc] init];
      restaurant.ID = [item objectForKey:@"id"];
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
