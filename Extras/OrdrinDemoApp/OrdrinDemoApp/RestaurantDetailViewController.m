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

#import "RestaurantDetailViewController.h"
#import "OIRestaurant.h"
#import "OICore.h"
#import "RestaurantDetailView.h"
#import "RestaurantDetailDataSource.h"
#import "OIDelivery.h"
#import "OIDateTime.h"

@interface RestaurantDetailViewController (Private)
- (void)createModel;
@end

@implementation RestaurantDetailViewController

#pragma mark -
#pragma mark Initializations

- (id)initWithRestaurant:(OIRestaurant *)restaurant {
  self = [super init];
  if ( self ) {
    self.title = @"Detail";
    __restaurant = [restaurant retain];
  }
  
  return self;
}

#pragma mark -
#pragma mark Lifecycles

- (void)loadView {
  [super loadView];
  
  __restaurantDetailView = [[RestaurantDetailView alloc] init];
  self.view = __restaurantDetailView;
  
  [self createModel];
}

- (void)viewDidUnload {
  [super viewDidUnload];
  
  [self releaseWithDealloc:NO];
}

#pragma mark -
#pragma mark Memory management

- (void)releaseWithDealloc:(BOOL)dealloc {  
  OI_RELEASE_SAFELY( __restaurantDetailView );
  if ( dealloc ) {
    OI_RELEASE_SAFELY( __restaurant );
    OI_RELEASE_SAFELY( __restaurantDetailDataSource );
  }  
}

- (void)dealloc {
  [self releaseWithDealloc:YES];
  
  [super dealloc];
}

@end

#pragma mark -
#pragma mark Private

@implementation RestaurantDetailViewController (Private)

- (void)createModel {
  [__restaurant deliveryCheckToAddress:__restaurant.address atTime:[OIDateTime dateTimeASAP] usingBlock:^void ( OIDelivery *delivery ){   
    __restaurantDetailDataSource = [[RestaurantDetailDataSource alloc] initWithRestaurant:__restaurant delivery:delivery];
    __restaurantDetailView.tableView.dataSource = __restaurantDetailDataSource;  
  }];  
}

@end
