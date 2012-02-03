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
#import "OIMainViewController.h"

@implementation OIMainViewController {

}

#pragma mark -
#pragma mark Lifecycle

- (void)loadView {
  [super loadView];

  self.view.backgroundColor = [UIColor whiteColor];

  // List of restaurants

  OIRestaurantAddress *address = [OIRestaurantAddress restaurantAddressWithStreet:@"1 Main St"
                                                                             city:@"College Station"
                                                                       postalCode:[NSNumber numberWithInt:77840]];

  [OIRestaurant restaurantsNearAddress:address availableAt:nil usingBlock:^void(NSArray *restaurants) {
    NSLog(@"%@", restaurants);
  }];
}

@end