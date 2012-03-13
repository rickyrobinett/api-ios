
#import "RestaurantsPopoverViewController.h"
#import "RestaurantListView.h"
#import "OICore.h"

@implementation RestaurantsPopoverViewController

#pragma mark -
#pragma mark Initializations

- (id)initWithRestaurants:(NSArray *)restaurants {
  self = [super init];
  if ( self ) {
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
    OI_RELEASE_SAFELY( __restaurants );      
  }
}
- (void)dealloc {
  [self releaseWithDealloc:YES];
  [super dealloc];
}

@end
