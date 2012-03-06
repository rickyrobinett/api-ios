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

#import "RestaurantDetailDataSource.h"
#import "OIRestaurant.h"
#import "OICore.h"
#import "OIDelivery.h"
#import "OIAddress.h"

static NSString *cellIdentifier = @"DetailCellIdentifier";

@implementation RestaurantDetailDataSource

#pragma mark -
#pragma mark Initializations

- (id)initWithRestaurant:(OIRestaurant *)restaurant delivery:(OIDelivery *)delivery {
  self = [super init];
  if ( self ) {
    __delivery = [delivery retain];
    __restaurant = [restaurant retain];
  }
  
  return self;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if ( section == 0 ) {
    if ( [__delivery isAvailable] ) {
      return 2;
    }
    
    return 1;
  }
  else {
    return 4;
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if ( ! cell ) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
  }
  
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
  
  if ( indexPath.section == 0 ) {
    switch (indexPath.row) {
      case 0: {
        if ( ! [__delivery isAvailable] ) {
          cell.textLabel.text = __delivery.message;
          cell.textLabel.numberOfLines = 3;
        }
        else {
          cell.textLabel.text = [NSString stringWithFormat:@"Expected time: %@", __delivery.expectedTime];
        }
        break;
      }
      case 1:
        cell.textLabel.text = [NSString stringWithFormat:@"Minimum: %@", __delivery.minimumAmount];
        break;
    }
  }
  else if ( indexPath.section == 1 ) {
    switch (indexPath.row) {
      case 0:
        cell.textLabel.text = [NSString stringWithFormat:@"phone: %@", __restaurant.phone];
        break;
        
      case 1:
        cell.textLabel.text = [NSString stringWithFormat:@"address: %@", __restaurant.address.address1];
        break;
        
      case 2:
        cell.textLabel.text = [NSString stringWithFormat:@"city: %@ %@", __restaurant.address.postalCode, __restaurant.address.city];
        break;
        
      case 3:
        cell.textLabel.text = [NSString stringWithFormat:@"state: %@", __restaurant.state];
        break;         
    }
  }
  
  return cell;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  OI_RELEASE_SAFELY( __restaurant );
  OI_RELEASE_SAFELY( __delivery );
  
  [super dealloc];
}

@end
