
#import "UserAddressesView.h"
#import "OICore.h"

@implementation UserAddressesView

@synthesize tableView = __tableView;

#pragma mark -
#pragma mark Initializations

- (id)init {
  self = [super init];
  if ( self ) {
    __tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];    
    [self addSubview:__tableView];
  }
  
  return self;
}

#pragma mark -
#pragma mark Lifecycles

- (void)layoutSubviews {
  [super layoutSubviews];
  
  if ( !CGRectEqualToRect(self.frame, __tableView.frame) ) {
    __tableView.frame = self.frame;
  }
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  OI_RELEASE_SAFELY( __tableView );
  [super dealloc];
}

@end
