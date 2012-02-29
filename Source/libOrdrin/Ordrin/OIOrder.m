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
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Variables

NSString *const OIOrderBaseURL = @"https://o-test.ordr.in";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Implementation

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
  
  NSString *URL = [NSString stringWithFormat:@"%@/o/%@", OIOrderBaseURL, __restaurantBase.ID];
  
  __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:URL]];
  
#warning Complete POST request
  [request setCompletionBlock:^{
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
  
  [super dealloc];
}

@end
