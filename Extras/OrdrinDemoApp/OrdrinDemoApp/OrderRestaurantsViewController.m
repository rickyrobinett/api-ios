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

#import "OrderRestaurantsViewController.h"
#import "RestaurantListView.h"
#import "OICore.h"
#import "OrderRestaurantsDataSource.h"

@interface OrderRestaurantsViewController (Private)
- (void)createModel;
@end

@implementation OrderRestaurantsViewController

@synthesize delegate = __delegate;

#pragma mark -
#pragma mark Initializations

- (id)initWithRestaurants:(NSArray *)restaurants {
  self = [super init];
  if ( self ) {
    self.title = @"Restaurants";
    __restaurants = [restaurants retain];    
  }
  
  return self;
}

#pragma mark -
#pragma mark Lifecycles

- (void)loadView {
  [super loadView];
  
  __restaurantListView = [[RestaurantListView alloc] init];
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
  [__delegate restaurantDidSelect:indexPath.row];
  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Memory management

- (void)releaseWithDealloc:(BOOL)dealloc {
  OI_RELEASE_SAFELY( __restaurantListView );
  if ( dealloc ) {
    __delegate = nil;
    OI_RELEASE_SAFELY( __restaurants ); 
    OI_RELEASE_SAFELY( __dataSource );
  }
}
- (void)dealloc {
  [self releaseWithDealloc:YES];
  [super dealloc];
}

@end

#pragma mark -
#pragma mark Private

@implementation OrderRestaurantsViewController (Private)

- (void)createModel {
  __dataSource = [[OrderRestaurantsDataSource alloc] initWithRestaurants:__restaurants]; 
  __restaurantListView.tableView.dataSource = __dataSource;
  __restaurantListView.tableView.delegate = self;
}

@end
