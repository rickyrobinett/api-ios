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
  NSString    *__restaurantID;
  OIUser      *__user;
  OIAddress   *__address;
  OICardInfo  *__cardInfo;
}

@synthesize restaurantID = __restaurantID;
@synthesize address      = __address;
@synthesize cardInfo     = __cardInfo;
@synthesize user         = __user;

#pragma mark -
#pragma mark Network

- (void)orderWithPassword:(NSString *)password usingBlock:(void (^)(NSError *error))block {
  NSString *URL = [NSString stringWithFormat:@"%@/o/%@", OIOrderBaseURL, __restaurantID];
  
  __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:URL]];
  
  [request setCompletionBlock:^{
    if ( block ) {
      block( nil );
    }
  }];
  
  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES];
}

#pragma mark -
#pragma mark Order Operations
- (NSNumber *) calculateSubtotal {
    
    //TODO: Define body
    return nil;
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __restaurantID );
  OI_RELEASE_SAFELY( __address );
  OI_RELEASE_SAFELY( __cardInfo );
  OI_RELEASE_SAFELY( __user );
  
  [super dealloc];
}

@end
