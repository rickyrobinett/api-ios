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

@implementation OIRestaurant {

}

#pragma mark -
#pragma mark Class methods

+ (void)restaurantsNearAddress:(OIRestaurantAddress *)address availableAt:(OIDateTime *)dateTime usingBlock:(void (^)(NSArray *restaurants))block {
  __block ASIHTTPRequest *request = [OIRequestFactory authenticatedRequestWithURL:[NSURL URLWithString:@"https://r-test.ordr.in/dl/"]];
  [request startAsynchronous];
}

@end