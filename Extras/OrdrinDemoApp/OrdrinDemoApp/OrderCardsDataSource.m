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

#import "OrderCardsDataSource.h"
#import "OICore.h"
#import "TextViewCell.h"
#import "OICardInfo.h"

static NSString *cellIdentifier = @"orderCardsCellIdentifier";
@implementation OrderCardsDataSource

@synthesize creditcards = __creditCards;

#pragma mark -
#pragma mark Initializations

- (id)initWithCreditCards:(NSArray *)creditCards {
  self = [super init];
  if ( self ) {
    __creditCards = [creditCards retain];    
  }
  
  return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return __creditCards.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  OICardInfo *cardInfo = [__creditCards objectAtIndex:indexPath.row];
  TextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if ( !cell ) {
    cell = [[[TextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
  }  
  [cell setTitle:cardInfo.type];
  
  return cell;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  OI_RELEASE_SAFELY( __creditCards );
  [super dealloc];
}
@end
