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

#import "RestaurantListViewController.h"
#import "RestaurantListView.h"
#import "OICore.h"
#import "OIAddress.h"
#import "RestaurantListDataSource.h"

@interface RestaurantListViewController (Private)
- (void)createModel;
@end

@implementation RestaurantListViewController

#pragma mark -
#pragma mark Initializations

- (id)initWithAddress:(OIAddress *)address {
  self = [super init];
  if ( self ) {
    __address = [address retain];
  }
  
  return self;
}

#pragma mark -
#pragma mark Lifecycles

- (void)loadView {
  [super loadView];
  
  __restaurantListView = [[RestaurantListView alloc] init];
  __restaurantListView.tableView.delegate = self;
  self.view = __restaurantListView;
  
  [self createModel];
}

- (void)viewDidUnload {
  [super viewDidUnload];
  
  [self releaseWithDealloc:NO];
}

#pragma mark -
#pragma mark Memory management

- (void)releaseWithDealloc:(BOOL)dealloc {   
  OI_RELEASE_SAFELY( __restaurantListView );
  if ( dealloc ) {
    OI_RELEASE_SAFELY( __address );
  }  
}

- (void)dealloc {
  [self releaseWithDealloc:YES];
  
  [super dealloc];
}

@end

#pragma mark -
#pragma mark Private

@implementation RestaurantListViewController (Private)

- (void)createModel {
  __restaurantListView.tableView.dataSource = [[RestaurantListDataSource alloc] initWithAddress:__address];
}

@end
