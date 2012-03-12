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

#import "UserOrdersViewController.h"
#import "UserOrdersView.h"
#import "OICore.h"
#import "UserOrdersModel.h"
#import "AddressFormView.h"
#import "NewOrderViewController.h"

#define ADDRESS_FORM_FRAME        CGRectMake(35, 60, 250, 270)

@interface UserOrdersViewController (Private)
- (void)findButtonDidPress;
- (void)newOrderButtonDidPress;
- (void)ordersDidLoadNotification:(NSNotification *)notification;
@end

@implementation UserOrdersViewController

#pragma mark -
#pragma mark Initializations

- (id)init {
  self = [super init];
  if ( self ) {
    self.title = @"Orders";
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newOrderButtonDidPress)];
    self.navigationItem.rightBarButtonItem = buttonItem;
    OI_RELEASE_SAFELY( buttonItem );
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ordersDidLoadNotification:) name:kOrdersDidLoadNotification object:nil];
  }
  
  return self;
}

#pragma mark -
#pragma mark Lifecycle

- (void)loadView {
  [super loadView];
  
  __userOrdersView = [[UserOrdersView alloc] init];
  self.view = __userOrdersView;
}

- (void)viewDidUnload {
  [super viewDidUnload];
  
  [self releaseWithDealloc:NO];
}

#pragma mark -
#pragma mark Memory management

- (void)releaseWithDealloc:(BOOL)dealloc {
  OI_RELEASE_SAFELY( __userOrdersView );
  OI_RELEASE_SAFELY( __addressForm );  
  if ( dealloc ) {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kOrdersDidLoadNotification object:nil];    
  }  
}

- (void)dealloc {
  [self releaseWithDealloc:YES];
  [super dealloc];
}

@end

#pragma mark -
#pragma mark Private

@implementation UserOrdersViewController (Private)

- (void)findButtonDidPress {
  [__addressForm removeFromSuperview];
  OI_RELEASE_SAFELY( __addressForm );
  
  NewOrderViewController *newOrderViewController = [[NewOrderViewController alloc] init];
  [self.navigationController pushViewController:newOrderViewController animated:YES];
  
  OI_RELEASE_SAFELY( newOrderViewController );
}

- (void)newOrderButtonDidPress {

  if ( !__addressForm ) {
    __addressForm = [[AddressFormView alloc] initWithFrame:ADDRESS_FORM_FRAME];
    __addressForm.backgroundColor = [UIColor grayColor];
    __addressForm.alpha = 0;
    [__addressForm.findButton addTarget:self action:@selector(findButtonDidPress) forControlEvents:UIControlEventTouchDown];
    [__userOrdersView addSubview:__addressForm];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0.5];
    __addressForm.alpha = 0.7;
    [UIView commitAnimations];    
  }
}

- (void)ordersDidLoadNotification:(NSNotification *)notification {
  [__userOrdersView.tableView reloadData];
}

@end
