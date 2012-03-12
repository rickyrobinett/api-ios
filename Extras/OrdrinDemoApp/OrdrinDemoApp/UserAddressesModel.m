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

#import "UserAddressesModel.h"
#import "OICore.h"
#import "OIAddress.h"

@interface UserAddressesModel (Private)
- (void)initAllAddresses;
@end

@implementation UserAddressesModel

@synthesize items = __items;

#pragma mark -
#pragma mark Initializations

- (id)init {
  self = [super init];
  if ( self ) {
    [self initAllAddresses];
  }

  return self;
}

#pragma mark -
#pragma mark Public

- (void)reload {
  if ( __items ) {
    OI_RELEASE_SAFELY( __items );
  }
  
  [self initAllAddresses];
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

@implementation UserAddressesModel (Private)

- (void)initAllAddresses {
  [OIAddress loadAddressesUsingBlock:^void( NSMutableArray *addresses ) {
    __items = [[NSMutableArray alloc] initWithArray:addresses];
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddressesDidLoadNotification object:nil];
  }];  
}

@end