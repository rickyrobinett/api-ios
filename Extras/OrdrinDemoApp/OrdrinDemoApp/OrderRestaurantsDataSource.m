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

#import "OrderRestaurantsDataSource.h"
#import "OICore.h"
#import "OIRestaurantBase.h"
#import "TextViewCell.h"

@implementation OrderRestaurantsDataSource

#pragma mark -
#pragma mark Initializations

- (id)initWithRestaurants:(NSArray *)restaurants {
  self = [super init];
  if ( self ) {
    __restaurants = [restaurants retain];
  }
  
  return self;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return __restaurants.count;  
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  OIRestaurantBase *restaurant = [__restaurants objectAtIndex:indexPath.row];

  TextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@""];        
  if ( !cell ) {  
    cell = [[[TextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""] autorelease];
  }
  
  [cell setTitle:[NSString stringWithFormat:@"%@", restaurant.name]];
  
  return cell;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  OI_RELEASE_SAFELY( __restaurants );
  [super dealloc];
}

@end
