
#import <UIKit/UIKit.h>

@class RestaurantListView;

@interface RestaurantsPopoverViewController : UIViewController {

@private
  NSArray *__restaurants;
  RestaurantListView *__restaurantListView;
}

- (id)initWithRestaurants:(NSArray *)restaurants;
@end
