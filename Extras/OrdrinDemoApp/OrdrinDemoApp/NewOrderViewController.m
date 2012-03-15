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
#import "OIMenuItem.h"

#import "NewOrderView.h"
#import "NewOrderModel.h"
#import "MenuItemsDataSource.h"

@interface NewOrderViewController (UserAction)
- (void)creditCardsButtonDidPress;
- (void)restaurantsButtonDidPress;
- (void)addressesButtonDidPress;
- (void)saveButtonDidPress;
- (void)datePickerDidChanged:(id)source;
@end

@interface NewOrderViewController (Private)
- (void)hideKeyboard;
- (void)createModel;
- (void)initRestaurantMenu;
- (NSString *)createStringFromOrderItems;
@end

@implementation NewOrderViewController

#pragma mark -
#pragma mark Initializations

- (id)initWithAddress:(OIAddress *)address {
  self = [super init];
  if ( self ) {
    __orderItems = [[NSMutableDictionary alloc] init];
    __selectedDate = [[NSDate alloc] init];
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
  [__newOrderView.datePicker addTarget:self action:@selector(datePickerDidChanged:) forControlEvents:UIControlEventValueChanged];
    
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
#pragma mark OrderRestaurantsDelegate

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

#pragma mark -
#pragma mark OrderAddressesDelegate

- (void)addressDidSelect:(NSUInteger)index {
  if ( __selectedAddress ) {
    OI_RELEASE_SAFELY( __selectedAddress );
  }
  
  OIAddress *address = [__newOrderModel.addresses objectAtIndex:index];
  [__newOrderView.addressesButton setTitle:[NSString stringWithFormat:@"%@, %@, %@",address.address1, address.city, address.state] forState:UIControlStateNormal];
  __selectedAddress = [address retain];
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
  OIMenuItem *menuItem = [__selectedRestaurant.menu objectAtIndex:indexPath.section];
  NSNumber *count = [__orderItems objectForKey:menuItem.ID];
  if ( count ) {
    NSUInteger countInt = count.integerValue;
    countInt++;
    [__orderItems setValue:[NSNumber numberWithInteger:countInt] forKey:menuItem.ID];    
  } else {
    [__orderItems setValue:[NSNumber numberWithInteger:1] forKey:menuItem.ID];
  }
}

#pragma mark -
#pragma mark Events

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [self hideKeyboard];  
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
    OI_RELEASE_SAFELY( __selectedDate );
    OI_RELEASE_SAFELY( __orderItems );
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
  if ( __newOrderModel.creditCards.count < 1 ) {
    return;
  }
  OrderCardsViewController *cardsViewController = [[OrderCardsViewController alloc] initWithCreditCards:__newOrderModel.creditCards];
  cardsViewController.delegate = self;
  [self.navigationController pushViewController:cardsViewController animated:YES];
  OI_RELEASE_SAFELY( cardsViewController );
}

- (void)addressesButtonDidPress {
  if ( __newOrderModel.addresses.count < 1 ) {
    return;
  }  
  OrderAddressesViewController *addressesViewController = [[OrderAddressesViewController alloc] initWithAddresses:__newOrderModel.addresses];  
  addressesViewController.delegate = self;
  [self.navigationController pushViewController:addressesViewController animated:YES];
  OI_RELEASE_SAFELY( addressesViewController );
}

- (void)restaurantsButtonDidPress {
  if ( __newOrderModel.restaurants.count < 1 ) {
    return;
  }  
  OrderRestaurantsViewController *restaurantsViewController = [[OrderRestaurantsViewController alloc] initWithRestaurants:__newOrderModel.restaurants];
  restaurantsViewController.delegate = self;
  [self.navigationController pushViewController:restaurantsViewController animated:YES];
  OI_RELEASE_SAFELY( restaurantsViewController );
}

- (void)saveButtonDidPress {
  NSString *orderItemsStr = [self createStringFromOrderItems];
  NSNumber *tip = [NSNumber numberWithInteger:__newOrderView.tipField.text.integerValue];
  __selectedCard.number = __newOrderView.cardNumberField.text;
  __selectedCard.cvc = [NSNumber numberWithInteger:__newOrderView.securityCodeField.text.integerValue];
  
  if ( !orderItemsStr || !tip || !__selectedRestaurant || !__selectedAddress || !__selectedCard || !__selectedDate ) {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please fill all fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    
    OI_RELEASE_SAFELY( alertView );
    
    return;
  }
  
  [OIOrder createOrderWithRestaurantId:__selectedRestaurant.ID atAddress:__selectedAddress withCard:__selectedCard date:__selectedDate orderItems:orderItemsStr tip:tip usingBlock:^void( NSError *error ) {
    if ( error ) {
      UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:error.domain delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
      [alertView show];
      
      OI_RELEASE_SAFELY( alertView );
    }
  }];
}

- (void)datePickerDidChanged:(id)source {
  if ( __selectedDate ) {
    OI_RELEASE_SAFELY( __selectedDate );
  }
  
  UIDatePicker *datePicker = source;
  __selectedDate = [datePicker.date retain];
}

@end

@implementation NewOrderViewController (Private)

- (NSString *)createStringFromOrderItems {
  NSMutableString *ordersStr = [NSMutableString string];
  
  NSArray *keys = __orderItems.allKeys;
  NSNumber *count;
  for ( int i = 0; i < keys.count; i++ ) {
    NSString *key = [keys objectAtIndex:i];
    count = [__orderItems objectForKey:key];
    [ordersStr appendFormat:@"%@/%@", key, count];
    if ( (i + 1) < keys.count ) {
      [ordersStr appendString:@"+"];
    }
  }
  
  return ordersStr;
}

- (void)hideKeyboard {
  [__newOrderView.cardNumberField resignFirstResponder];
  [__newOrderView.securityCodeField resignFirstResponder];
}

- (void)createModel {
  __newOrderModel = [[NewOrderModel alloc] initWithAddress:__address];
}

- (void)initRestaurantMenu {
  if ( __menuItemsDataSource ) {
    OI_RELEASE_SAFELY( __menuItemsDataSource );
  }
  
  __menuItemsDataSource = [[MenuItemsDataSource alloc] initWithMenuItems:__selectedRestaurant.menu];
  __newOrderView.tableView.dataSource = __menuItemsDataSource;
  __newOrderView.tableView.delegate = self;
  [__newOrderView.tableView reloadData];
}

@end