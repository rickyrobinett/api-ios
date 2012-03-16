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
#import "OIDeliveryCheckViewController.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Interface

@interface OIDeliveryCheckViewController()< UITableViewDataSource, UITableViewDelegate >

@property (nonatomic, readwrite, retain) OIDelivery *delivery;

- (void)reload;
- (void)releaseWithDealloc:(BOOL)dealloc;
@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Implementation

@implementation OIDeliveryCheckViewController {
@private
  OIRestaurant *__restaurant;
  OIDelivery   *__delivery;
  UITableView  *__tableView;
}

@synthesize restaurant = __restaurant;
@synthesize delivery   = __delivery;

#pragma mark -
#pragma mark Lifecycle

- (void)loadView {
  [super loadView];

  self.title = NSLocalizedString( @"Delivery", "" );

  __tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
  __tableView.delegate = self;
  __tableView.dataSource = self;
  [self.view addSubview:__tableView];

  // Check delivery
  NSNumber *postalCode = [NSNumber numberWithInteger:__restaurant.address.postalCode.integerValue];
  OIAddress *address = [OIAddress addressWithStreet:__restaurant.address.address1 city:__restaurant.address.city postalCode:postalCode];
  OIDateTime *dateTime = [OIDateTime dateTimeASAP];
    
  [__restaurant deliveryCheckToAddress:address atTime:dateTime usingBlock:^void(OIDelivery *delivery) {
    self.delivery = delivery;
    [self reload];
  }];
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
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if ( section == 0 ) {
    if ( [__delivery isAvailable] ) {
      return 2;
    }

    return 1;
  }
  else if ( section == 1 ) {
    return 4;
  }

  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
  if ( ! cell ) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] autorelease];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
  }

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
#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if ( [__delivery isAvailable] == NO ) {
    return 58.0f;
  }

  return 44.0f;
}

#pragma mark -
#pragma mark Memory Management

- (void)releaseWithDealloc:(BOOL)dealloc {
  [__tableView release], __tableView = nil;

  if ( dealloc ) {
    [__restaurant release], __restaurant = nil;
    [__delivery release], __delivery = nil;
  }
}

- (void)viewDidUnload {
  [self releaseWithDealloc:NO];
  [super viewDidUnload];
}

- (void)dealloc {
  [self releaseWithDealloc:YES];
  [super dealloc];
}

@end