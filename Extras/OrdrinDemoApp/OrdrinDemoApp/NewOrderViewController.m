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

#import "NewOrderViewController.h"
#import "NewOrderView.h"
#import "OICore.h"
#import "OIOrder.h"
#import "NewOrderModel.h"
#import "OIAddress.h"
#import "RestaurantsPopoverViewController.h"
#import "OIRestaurantBase.h"
#import "OIRestaurant.h"
#import "MenuItemsDataSource.h"
#import "OIUserInfo.h"

@interface NewOrderViewController (Private)
- (void)restaurantDidSelectNotification:(NSNotification *)notification;
- (void)restaurantsButtonDidPress;
- (void)addressesButtonDidPress;
- (void)saveButtonDidPress;
- (void)createModel;
- (void)initRestaurantMenu;
@end

@implementation NewOrderViewController

#pragma mark -
#pragma mark Initializations

- (id)initWithAddress:(OIAddress *)address {
  self = [super init];
  if ( self ) {
    OIUserInfo *userInfo = [OIUserInfo sharedInstance];
    self.title = [NSString stringWithFormat:@"%@ %@",userInfo.firstName, userInfo.lastName];
    __address = [address retain];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonDidPress)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    OI_RELEASE_SAFELY( saveButton );
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restaurantDidSelectNotification:) name:kRestaurantDidSelectNotification object:nil];
  }  
  return self;
}

#pragma mark -
#pragma mark Lifecycles

- (void)loadView {
  [super loadView];
  
  __newOrderView = [[NewOrderView alloc] init];
  [__newOrderView.restaurantsButton addTarget:self action:@selector(restaurantsButtonDidPress) forControlEvents:UIControlEventTouchDown];  
  [__newOrderView.addressesButton addTarget:self action:@selector(addressesButtonDidPress) forControlEvents:UIControlEventTouchDown];
  
  self.view = __newOrderView;
  [self createModel];
}

- (void)viewDidUnload {
  [super viewDidUnload];
  
  [self releaseWithDealloc:NO];
}

#pragma mark -
#pragma mark Memory management

- (void)releaseWithDealloc:(BOOL)dealloc {   
  OI_RELEASE_SAFELY( __newOrderView );
  if ( dealloc ) {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kRestaurantDidSelectNotification object:nil];
    OI_RELEASE_SAFELY( __address );
    OI_RELEASE_SAFELY( __newOrderModel );
    OI_RELEASE_SAFELY( __selectedRestaurant );
    OI_RELEASE_SAFELY( __menuItemsDataSource );
  }  
}

- (void)dealloc {
  [self releaseWithDealloc:YES];
  [super dealloc];
}

@end

#pragma mark -
#pragma mark Private

@implementation NewOrderViewController (Private)

- (void)addressesButtonDidPress {
}

- (void)restaurantDidSelectNotification:(NSNotification *)notification {
  if ( __selectedRestaurant ) {
    OI_RELEASE_SAFELY( __selectedRestaurant );
  }
  
  NSNumber *row = [notification.userInfo objectForKey:@"row"];
  OIRestaurantBase *restaurantBase = [__newOrderModel.restaurants objectAtIndex:row.integerValue];
  [__newOrderView.restaurantsButton setTitle:restaurantBase.name forState:UIControlStateNormal];  
  [OIRestaurant createRestaurantByRestaurantBase:restaurantBase usingBlock:^void( OIRestaurant *restaurant ) {
    __selectedRestaurant = [restaurant retain];
    [self initRestaurantMenu];
  }];
}

- (void)restaurantsButtonDidPress {
  RestaurantsPopoverViewController *restaurantsViewController = [[RestaurantsPopoverViewController alloc] initWithRestaurants:__newOrderModel.restaurants];
  
  [self.navigationController pushViewController:restaurantsViewController animated:YES];
  OI_RELEASE_SAFELY( restaurantsViewController );
}

- (void)createModel {
  __newOrderModel = [[NewOrderModel alloc] initWithAddress:__address];
}

- (void)saveButtonDidPress {
  OIOrder *order = [[OIOrder alloc] init];
  [order orderForUser:nil atAddress:nil withCard:nil usingBlock:^void( NSError *error ) {
    
  }];
}

- (void)initRestaurantMenu {
  if ( __menuItemsDataSource ) {
    OI_RELEASE_SAFELY( __menuItemsDataSource );
  }
  
  __menuItemsDataSource = [[MenuItemsDataSource alloc] initWithMenuItems:__selectedRestaurant.menu];
  __newOrderView.tableView.dataSource = __menuItemsDataSource;
  [__newOrderView.tableView reloadData];
}

@end