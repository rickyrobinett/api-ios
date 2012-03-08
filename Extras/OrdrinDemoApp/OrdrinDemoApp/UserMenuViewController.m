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

#import "UserMenuViewController.h"
#import "OIUserInfo.h"
#import "UserMenuView.h"
#import "OICore.h"
#import "AccountInfoViewController.h"
#import "UserAddressesViewController.h"
#import "OIAddress.h"
#import "OICardInfo.h"
#import "UserCreditCardsViewController.h"
#import "ChangePasswordViewController.h"

@interface UserMenuViewController (UserAction)
- (void)accountInfoButtonDidPress;
- (void)addressButtonDidPress;
- (void)creditCardsButtonDidPress;
- (void)ordersHistoryButtonDidPress;
- (void)passwordButtonDidPress;
- (void)logoutButtonDidPress;
@end

@implementation UserMenuViewController

#pragma mark -
#pragma mark Initializations

- (id)init {
  self = [super init];
  if ( self ) {
    OIUserInfo *userInfo = [OIUserInfo sharedInstance];
    self.title = [NSString stringWithFormat:@"%@ %@", userInfo.firstName, userInfo.lastName];
  }
  
  return self;
}

#pragma mark -
#pragma mark Lifecycle

- (void)loadView {
  [super loadView];
  
  __userMenuView = [[UserMenuView alloc] init];
  
  [__userMenuView.accountInfoButton addTarget:self action:@selector(accountInfoButtonDidPress) forControlEvents:UIControlEventTouchDown];
  [__userMenuView.addressButton addTarget:self action:@selector(addressButtonDidPress) forControlEvents:UIControlEventTouchDown];
  [__userMenuView.creditCardsButton addTarget:self action:@selector(creditCardsButtonDidPress) forControlEvents:UIControlEventTouchDown];
  [__userMenuView.ordersHistoryButton addTarget:self action:@selector(ordersHistoryButtonDidPress) forControlEvents:UIControlEventTouchDown];
  [__userMenuView.passwordButton addTarget:self action:@selector(passwordButtonDidPress) forControlEvents:UIControlEventTouchDown];
  [__userMenuView.logoutButton addTarget:self action:@selector(logoutButtonDidPress) forControlEvents:UIControlEventTouchDown];
  
  self.view  = __userMenuView;
}

- (void)viewDidUnload {
  [super viewDidUnload];
  
  [self releaseWithDealloc:NO];
}

#pragma mark -
#pragma mark Memory management

- (void)releaseWithDealloc:(BOOL)dealloc {
  OI_RELEASE_SAFELY( __userMenuView );
  if ( dealloc ) {
  }  
}

- (void)dealloc {
  [self releaseWithDealloc:YES];
  [super dealloc];
}

@end

#pragma mark -
#pragma mark User Actions

@implementation UserMenuViewController (UserAction)

- (void)accountInfoButtonDidPress {
  AccountInfoViewController *accountInfoViewController = [[AccountInfoViewController alloc] init];
  [self.navigationController pushViewController:accountInfoViewController animated:YES];
  OI_RELEASE_SAFELY( accountInfoViewController );
}

- (void)addressButtonDidPress {
  [OIAddress loadAddressesUsingBlock:^void( NSMutableArray *addresses ) {
    UserAddressesViewController *userAddressesViewController = [[UserAddressesViewController alloc] initWithAddresses:addresses];
    [self.navigationController pushViewController:userAddressesViewController animated:YES];
    OI_RELEASE_SAFELY( userAddressesViewController );    
  }];
}

- (void)creditCardsButtonDidPress {
  [OICardInfo loadCreditCardsUsingBlock:^void( NSMutableArray *creditCards ) {
    UserCreditCardsViewController *userCreditCardsViewController = [[UserCreditCardsViewController alloc] initWithCreditCards:creditCards];
    [self.navigationController pushViewController:userCreditCardsViewController animated:YES];
    OI_RELEASE_SAFELY( userCreditCardsViewController );
  }];
}

- (void)ordersHistoryButtonDidPress {
  
}

- (void)passwordButtonDidPress {
  ChangePasswordViewController *changePasswordViewController = [[ChangePasswordViewController alloc] init];
  [self.navigationController pushViewController:changePasswordViewController animated:YES];
  OI_RELEASE_SAFELY( changePasswordViewController );
}

- (void)logoutButtonDidPress {
  OIUserInfo *userInfo = [OIUserInfo sharedInstance];
  [userInfo logout];
  [self.navigationController popViewControllerAnimated:YES];
}

@end