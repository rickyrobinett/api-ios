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
#import "RestaurantListModel.h"
#import "OIRestaurantBase.h"
#import "OIRestaurant.h"
#import "RestaurantDetailViewController.h"
#import "OIDateTime.h"

@interface RestaurantListViewController (Private)
- (void)reloadTableView;
- (void)createModel;
@end

@implementation RestaurantListViewController

#pragma mark -
#pragma mark Initializations

- (id)initWithAddress:(OIAddress *)address {
  self = [super init];
  if ( self ) {
    self.title = @"Restaurants";
    __address = [address retain];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:kRestaurantsModelDidFinishNotification object:nil];
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
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  OIRestaurantBase *restaurantBase = [__restaurantDataSource.model.items objectAtIndex:indexPath.row]; 
  [OIRestaurant createRestaurantByRestaurantBase:restaurantBase usingBlock:^void( OIRestaurant *restaurant ) {
    [restaurant deliveryCheckToAddress:restaurant.address atTime:[OIDateTime dateTimeASAP] usingBlock:^void ( OIDelivery *delivery ){   
      RestaurantDetailViewController *detailViewController = [[RestaurantDetailViewController alloc] initWithRestaurant:restaurant delivery:delivery];
      [self.navigationController pushViewController:detailViewController animated:YES];    
      OI_RELEASE_SAFELY( detailViewController );      
    }];    
  }];
}

#pragma mark -
#pragma mark Memory management

- (void)releaseWithDealloc:(BOOL)dealloc {   
  OI_RELEASE_SAFELY( __restaurantListView );
  if ( dealloc ) {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kRestaurantsModelDidFinishNotification object:nil];
    OI_RELEASE_SAFELY( __address );
    OI_RELEASE_SAFELY( __restaurantDataSource );
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

- (void)reloadTableView {
  [__restaurantListView.tableView reloadData];
}

- (void)createModel {
  __restaurantDataSource = [[RestaurantListDataSource alloc] initWithAddress:__address];
  __restaurantListView.tableView.dataSource = __restaurantDataSource;
}

@end
