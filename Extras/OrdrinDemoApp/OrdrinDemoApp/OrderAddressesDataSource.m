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

#import "OrderAddressesDataSource.h"
#import "OICore.h"
#import "TextViewCell.h"
#import "OIAddress.h"

static NSString *cellIdentifier = @"orderAddressCellIdentifier";
@implementation OrderAddressesDataSource

#pragma mark -
#pragma mark Initializations

- (id)initWithAddresses:(NSArray *)addresses {
  self = [super init];
  if ( self ) {
    __addresses = [addresses retain];
  }
  
  return self;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return __addresses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  OIAddress *address = [__addresses objectAtIndex:indexPath.section];
  TextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if ( !cell ) {
    cell = [[[TextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
  }
  
  NSString *title = [NSString stringWithFormat:@"%@",address.addressAsString];
  [cell setTitle:title];
  
  return cell;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  OI_RELEASE_SAFELY( __addresses );
  [super dealloc];
}

@end
