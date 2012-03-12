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

#import "UserOrdersModel.h"
#import "OIOrder.h"
#import "OICore.h"

@interface UserOrdersModel (Private)
- (void)initAllOrders;
@end

@implementation UserOrdersModel

@synthesize items = __items;

#pragma mark -
#pragma mark Initializations

- (id)init {
  self = [super init];
  if ( self ) {
    [self initAllOrders];
  }
  
  return self;
}

#pragma mark -
#pragma mark Public

- (void)reload {
  if ( __items ) {
    OI_RELEASE_SAFELY( __items );
  }
  
  [self initAllOrders];
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  OI_RELEASE_SAFELY( __items );  
  [super dealloc];
}

@end

#pragma mark -
#pragma mark Private

@implementation UserOrdersModel (Private)

- (void)initAllOrders {
  [OIOrder loadOrderHistoryUsingBlock:^void( NSMutableArray *orders ) {
    __items = [[NSMutableArray alloc] initWithArray:orders];
    [[NSNotificationCenter defaultCenter] postNotificationName:kOrdersDidLoadNotification object:nil];    
  }];
}

@end