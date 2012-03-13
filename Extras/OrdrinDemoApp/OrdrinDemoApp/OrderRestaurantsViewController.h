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

#import <UIKit/UIKit.h>

@class RestaurantListView;
@class OrderRestaurantsDataSource;

@protocol OrderRestaurantsDelegate <NSObject>
- (void)restaurantDidSelect:(NSUInteger)index;
@end

@interface OrderRestaurantsViewController : UIViewController<UITableViewDelegate> {

@private
  id<OrderRestaurantsDelegate> __delegate;
  NSArray *__restaurants;
  RestaurantListView *__restaurantListView;
  OrderRestaurantsDataSource *__dataSource;
}

- (id)initWithRestaurants:(NSArray *)restaurants;

@property (nonatomic, assign) id<OrderRestaurantsDelegate> delegate;
@end
