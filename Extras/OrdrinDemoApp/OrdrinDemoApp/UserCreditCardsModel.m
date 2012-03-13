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

#import "UserCreditCardsModel.h"
#import "OICore.h"
#import "OICardInfo.h"

@interface UserCreditCardsModel (Private)
- (void)initAllCreditCards;
@end

@implementation UserCreditCardsModel
@synthesize items = __items;

#pragma mark -
#pragma mark Initializations

- (id)init {
  self = [super init];
  if ( self ) {
    [self initAllCreditCards];
  }

  return self;
}

#pragma mark -
#pragma mark Public

- (void)reload {
  if ( __items ) {
    OI_RELEASE_SAFELY( __items );
  }

  [self initAllCreditCards];
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

@implementation UserCreditCardsModel (Private)
- (void)initAllCreditCards {
  [OICardInfo loadCreditCardsUsingBlock:^void( NSMutableArray *creditCards ) {
    __items = [[NSMutableArray alloc] initWithArray:creditCards];
    [[NSNotificationCenter defaultCenter] postNotificationName:kCreditCardsDidLoadNotification object:nil];
  }];  
}

@end
