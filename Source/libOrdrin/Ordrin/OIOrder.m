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
#import "OIOrder.h"
#import "OICore.h"
#import "OIAddress.h"
#import "OICardInfo.h"
#import "OIUser.h"
#import "ASIFormDataRequest.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Variables

NSString *const OIOrderBaseURL = @"https://o-test.ordr.in";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Implementation

@implementation OIOrder {
@private
  NSString    *__orderID;
  NSString    *__restaurantID;
  NSString    *__restaurantName;
  NSNumber    *__total;
  NSNumber    *__tip;
  NSDate      *__date;
  NSArray     *__items;
}

@synthesize orderID        = __orderID;
@synthesize restaurantID   = __restaurantID;
@synthesize restaurantName = __restaurantName;
@synthesize total          = __total;
@synthesize tip            = __tip;
@synthesize date           = __date;
@synthesize items          = __items;

#pragma mark -
#pragma mark Instance methods

- (void)orderForUser:(OIUser *)user atAddress:(OIAddress*)address withCard:(OICardInfo *)card usingBlock:(void (^)(NSError *error))block {
  
  NSString *URL = [NSString stringWithFormat:@"%@/o/%@", OIOrderBaseURL, __restaurantID];
  
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
  OI_RELEASE_SAFELY( __restaurantID );
  OI_RELEASE_SAFELY( __restaurantName );
  OI_RELEASE_SAFELY( __total );
  OI_RELEASE_SAFELY( __tip );
  OI_RELEASE_SAFELY( __date );
  OI_RELEASE_SAFELY( __items );
  
  [super dealloc];
}

@end
