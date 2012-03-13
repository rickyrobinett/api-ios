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

#import "UserOrdersDataSource.h"
#import "UserOrdersModel.h"
#import "OICore.h"
#import "TextViewCell.h"
#import "OIOrder.h"
#import "OIRestaurantBase.h"

static NSString *cellOrderIdentifier = @"cellOrderIdentifier";

@implementation UserOrdersDataSource

#pragma mark -
#pragma mark Initializations

- (id)init {
  self = [super init];
  if ( self ) {    
  }
  
  return self;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return __model.items.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  OIOrder *order = [__model.items objectAtIndex:indexPath.section];  
  
  TextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellOrderIdentifier];        
  if ( !cell ) {  
    cell = [[[TextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellOrderIdentifier] autorelease];
  }

  switch ( indexPath.section ) {
    case 0:
      [cell setTitle:[NSString stringWithFormat:@"Order ID: %@", order.orderID]];
      break;            
    case 1:
      [cell setTitle:[NSString stringWithFormat:@"Restaurant: %@", order.restaurantBase.name]];
      break;            
    case 2:
      [cell setTitle:[NSString stringWithFormat:@"Total cost: %@ $",order.total]];
      break;            
    case 3:
      [cell setTitle:[NSString stringWithFormat:@"Tip: %@ $", order.tip]];
      break;            
    case 4:
      [cell setTitle:[NSString stringWithFormat:@"Time: %@", order.date]];
      break;            
    case 5:
      [cell setTitle:[NSString stringWithFormat:@"Items: "]];
      break;                  
  }
  
  return cell;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  OI_RELEASE_SAFELY( __model );
  [super dealloc];
}

@end
