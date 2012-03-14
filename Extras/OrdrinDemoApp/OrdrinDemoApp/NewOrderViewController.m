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
#import "OICore.h"
#import "OIOrder.h"
#import "OIUserInfo.h"
#import "OICardInfo.h"
#import "OIRestaurantBase.h"
#import "OIRestaurant.h"
#import "OIAddress.h"

#import "NewOrderView.h"
#import "NewOrderModel.h"
#import "MenuItemsDataSource.h"

@interface NewOrderViewController (UserAction)
- (void)creditCardsButtonDidPress;
- (void)restaurantsButtonDidPress;
- (void)addressesButtonDidPress;
- (void)saveButtonDidPress;
@end

@interface NewOrderViewController (Private)
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
  [__newOrderView.creditCardButton addTarget:self action:@selector(creditCardsButtonDidPress) forControlEvents:UIControlEventTouchDown];
  
  self.view = __newOrderView;
  [self createModel];
}

- (void)viewDidUnload {
  [super viewDidUnload];
  
  [self releaseWithDealloc:NO];
}

#pragma mark -
#pragma mark OrderCardsDelegate

- (void)creditCardDidSelect:(NSUInteger)index {
  if ( __selectedCard ) {
    OI_RELEASE_SAFELY( __selectedCard );
  }
  
  OICardInfo *creditCard = [__newOrderModel.creditCards objectAtIndex:index];
  [__newOrderView.creditCardButton setTitle:creditCard.type forState:UIControlStateNormal];
  __selectedCard = [creditCard retain];
}

#pragma mark -
#pragma mark OrderAddressesDelegate

- (void)restaurantDidSelect:(NSUInteger)index {
  if ( __selectedRestaurant ) {
    OI_RELEASE_SAFELY( __selectedRestaurant );
  }
  
  OIRestaurantBase *restaurantBase = [__newOrderModel.restaurants objectAtIndex:index];
  [__newOrderView.restaurantsButton setTitle:restaurantBase.name forState:UIControlStateNormal];  
  [OIRestaurant createRestaurantByRestaurantBase:restaurantBase usingBlock:^void( OIRestaurant *restaurant ) {
    __selectedRestaurant = [restaurant retain];
    [self initRestaurantMenu];
  }];  
}

- (void)addressDidSelect:(NSUInteger)index {
  if ( __selectedAddress ) {
    OI_RELEASE_SAFELY( __selectedAddress );
  }
  
  OIAddress *address = [__newOrderModel.addresses objectAtIndex:index];
  [__newOrderView.addressesButton setTitle:address.addressAsString forState:UIControlStateNormal];
  __selectedAddress = [address retain];
}

#pragma mark -
#pragma mark Memory management

- (void)releaseWithDealloc:(BOOL)dealloc {   
  OI_RELEASE_SAFELY( __newOrderView );
  if ( dealloc ) {
    OI_RELEASE_SAFELY( __address );
    OI_RELEASE_SAFELY( __newOrderModel );
    OI_RELEASE_SAFELY( __selectedRestaurant );
    OI_RELEASE_SAFELY( __selectedAddress );  
    OI_RELEASE_SAFELY( __selectedCard );    
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

@implementation NewOrderViewController (UserAction)

- (void)creditCardsButtonDidPress {
  OrderCardsViewController *cardsViewController = [[OrderCardsViewController alloc] initWithCreditCards:__newOrderModel.creditCards];
  cardsViewController.delegate = self;
  [self.navigationController pushViewController:cardsViewController animated:YES];
  OI_RELEASE_SAFELY( cardsViewController );
}

- (void)addressesButtonDidPress {
  OrderAddressesViewController *addressesViewController = [[OrderAddressesViewController alloc] initWithAddresses:__newOrderModel.addresses];  
  addressesViewController.delegate = self;
  [self.navigationController pushViewController:addressesViewController animated:YES];
  OI_RELEASE_SAFELY( addressesViewController );
}

- (void)restaurantsButtonDidPress {
  OrderRestaurantsViewController *restaurantsViewController = [[OrderRestaurantsViewController alloc] initWithRestaurants:__newOrderModel.restaurants];
  restaurantsViewController.delegate = self;
  [self.navigationController pushViewController:restaurantsViewController animated:YES];
  OI_RELEASE_SAFELY( restaurantsViewController );
}
- (void)saveButtonDidPress {
  [OIOrder createOrderWithRestaurantId:__selectedRestaurant.ID atAddress:__selectedAddress withCard:__selectedCard usingBlock:^void( NSError *error ) {
    if ( error ) {
      
    }
  }];
}

@end

@implementation NewOrderViewController (Private)

- (void)createModel {
  __newOrderModel = [[NewOrderModel alloc] initWithAddress:__address];
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