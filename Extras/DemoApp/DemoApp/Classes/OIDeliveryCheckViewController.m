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

  OIAddress *address = [OIAddress addressWithStreet:@"1 Main St"
                                               city:@"College Station"
                                         postalCode:[NSNumber numberWithInt:77840]];

  OIDateTime *dateTime = [OIDateTime dateTimeASAP];

//  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//  [formatter setDateFormat:@"MM-dd-yyyy HH:mm"];
//
//  OIDateTime *dateTime = [OIDateTime dateTime:[formatter dateFromString:@"02-03-2012 11:00"]];
//  [formatter release];
  
  [__restaurant deliveryCheckToAddress:address atTime:dateTime usingBlock:^void(OIDelivery *delivery) {
    self.delivery = delivery;
    [__tableView reloadData];
  }];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if ( __delivery ) {
    if ( [__delivery isAvailable] ) {
      return 2;
    }

    return 1;
  }

  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
  if ( ! cell ) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] autorelease];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:11.0f];
  }

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
  
  return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if ( [__delivery isAvailable] == NO ) {
    return 54.0f;
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