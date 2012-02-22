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
 *      Vitezslav Kot (vita@tapmates.com)
 */

#import "OIUserAddressesViewController.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Interface

@interface OIUserAddressesViewController()< UITableViewDataSource, UITableViewDelegate >

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Implementation

@implementation OIUserAddressesViewController {
@private
  UITableView *__tableView;
}

#pragma mark -
#pragma mark - View lifecycle

- (void)loadView {
  [super loadView];
  
  self.title = NSLocalizedString( @"Addresses", "" );
  
  __tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
  __tableView.delegate = self;
  __tableView.dataSource = self;
  [self.view addSubview:__tableView];
  
//  [__restaurant deliveryCheckToAddress:address atTime:dateTime usingBlock:^void(OIDelivery *delivery) {
//    self.delivery = delivery;
//    [self reload];
//  }];
//  
//  [__restaurant downloadAllUsingBlock:^void() {
//    [self reload];
//  }];
}


#pragma mark -
#pragma mark Private

- (void)reload {
  if ( [NSThread isMainThread] ) {
    [__tableView reloadData];    
  }
  else {
    dispatch_sync(dispatch_get_main_queue(), ^void() {
      [__tableView reloadData];
    });
  }
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  NSUInteger sections = 0;
//  if ( __delivery ) {
//    sections++;
//    
//    if ( [__restaurant isComplete] ) {
//      sections++;
//    }
//  }
  
  return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//  if ( section == 0 ) {
//    if ( [__delivery isAvailable] ) {
//      return 2;
//    }
//    
//    return 1;
//  }
//  else if ( section == 1 ) {
//    return 4;
//  }
  
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
//  if ( ! cell ) {
//    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] autorelease];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
//  }
//  
//  if ( indexPath.section == 0 ) {
//    switch (indexPath.row) {
//      case 0: {
//        if ( ! [__delivery isAvailable] ) {
//          cell.textLabel.text = __delivery.message;
//          cell.textLabel.numberOfLines = 3;
//        }
//        else {
//          cell.textLabel.text = [NSString stringWithFormat:@"Expected time: %@", __delivery.expectedTime];
//        }
//        break;
//      }
//      case 1:
//        cell.textLabel.text = [NSString stringWithFormat:@"Minimum: %@", __delivery.minimumAmount];
//        break;
//    }
//  }
//  else if ( indexPath.section == 1 ) {
//    switch (indexPath.row) {
//      case 0:
//        cell.textLabel.text = [NSString stringWithFormat:@"phone: %@", __restaurant.phone];
//        break;
//        
//      case 1:
//        cell.textLabel.text = [NSString stringWithFormat:@"address: %@", __restaurant.address.street];
//        break;
//        
//      case 2:
//        cell.textLabel.text = [NSString stringWithFormat:@"city: %@ %@", __restaurant.address.postalCode, __restaurant.address.city];
//        break;
//        
//      case 3:
//        cell.textLabel.text = [NSString stringWithFormat:@"state: %@", __restaurant.state];
//        break;         
//    }
//  }
  
  return cell;
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __tableView );
  
  [super dealloc];
}
@end
