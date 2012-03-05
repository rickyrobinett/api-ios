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
 *      Vitezslav Kot (vita@tapmates.com)
 */

#import "OIAccountNavigatorView.h"
#import "OIApplicationData.h"
#import "OIUserViewController.h"
#import "OIUserAccountSettingsViewController.h"
#import "OIUserAddressesViewController.h"
#import "OICardInfo.h"

@implementation OIAccountNavigatorView

#pragma mark -
#pragma mark Initialization

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    
    UIButton *__buttonAccountSettings = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    __buttonAccountSettings.frame = CGRectMake(35, 30, 250, 30);
    [__buttonAccountSettings setTitle:@"Account Info" forState:UIControlStateNormal];
    
    UIButton *__buttonAddresses = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    __buttonAddresses.frame = CGRectMake(35, 70, 250, 30);
    [__buttonAddresses setTitle:@"Addresses" forState:UIControlStateNormal]; 
    
    UIButton *__buttonCreditCards = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    __buttonCreditCards.frame = CGRectMake(35, 110, 250, 30);
    [__buttonCreditCards setTitle:@"Credit Cards" forState:UIControlStateNormal]; 
    
    UIButton *__buttonOrders = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    __buttonOrders.frame = CGRectMake(35, 150, 250, 30);
    [__buttonOrders setTitle:@"Order History Summary" forState:UIControlStateNormal]; 
    
    UIButton *__buttonPassword = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    __buttonPassword.frame = CGRectMake(35, 190, 250, 30);
    [__buttonPassword setTitle:@"Password" forState:UIControlStateNormal]; 
    
    UIButton *__buttonLogOut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    __buttonLogOut.frame = CGRectMake(35, 230, 250, 30);
    [__buttonLogOut setTitle:@"Log Out" forState:UIControlStateNormal];
    
    [__buttonAccountSettings addTarget:self action:@selector(buttonAccountSettingsPressed) forControlEvents:UIControlEventTouchUpInside]; 
    [__buttonAddresses addTarget:self action:@selector(buttonAddressesPressed) forControlEvents:UIControlEventTouchUpInside];
    [__buttonCreditCards addTarget:self action:@selector(buttonCreditCardsPressed) forControlEvents:UIControlEventTouchUpInside];
    [__buttonOrders addTarget:self action:@selector(buttonOrdersPressed) forControlEvents:UIControlEventTouchUpInside];
    [__buttonPassword addTarget:self action:@selector(buttonPasswordPressed) forControlEvents:UIControlEventTouchUpInside];
    [__buttonLogOut addTarget:self action:@selector(buttonLogOutPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:__buttonAccountSettings];
    [self addSubview:__buttonAddresses];
    [self addSubview:__buttonCreditCards];
    [self addSubview:__buttonOrders];  
    [self addSubview:__buttonPassword]; 
    [self addSubview:__buttonLogOut]; 
  }
  
  return self;
}

-(void)buttonAccountSettingsPressed {
  OIUserAccountSettingsViewController *controller = [[OIUserAccountSettingsViewController alloc] init];
  UIViewController* viewController = (UIViewController*) [[self superview] nextResponder]; 
  [viewController.navigationController pushViewController:controller animated:YES];
  [controller release]; 
}

-(void)buttonAddressesPressed {
  OIUserAddressesViewController *controller = [[OIUserAddressesViewController alloc] init];
  UIViewController* viewController = (UIViewController*) [[self superview] nextResponder]; 
  [viewController.navigationController pushViewController:controller animated:YES];
  [controller release]; 
}

- (void)buttonCreditCardsPressed {
  [OICardInfo loadCreditCardsUsingBlock:^void( NSMutableArray *creditCards ) {

  }];
}

- (void)buttonOrdersPressed {

}

- (void)buttonPasswordPressed {
  
}

- (void)buttonLogOutPressed {
  OIApplicationData *appDataManager = [OIApplicationData sharedInstance];
  [appDataManager logout];
  self.hidden = YES;
  UIViewController* viewController = (UIViewController*) [[self superview] nextResponder]; 
  [(OIUserViewController*)viewController refresh];
  
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  [super dealloc];
}
@end
