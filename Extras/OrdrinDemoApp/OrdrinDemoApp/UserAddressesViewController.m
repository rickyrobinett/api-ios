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

#import "UserAddressesViewController.h"
#import "UserAddressesView.h"
#import "UserAddressesDataSource.h"
#import "OICore.h"
#import "AddAddressViewController.h"
#import "UserAddressEditCell.h"
#import "OIAddress.h"

@interface UserAddressesViewController (Private)
- (void)deleteAddressNotification:(NSNotification *)notification;
- (void)editAddressNotification:(NSNotification *)notification;

- (void)createModel;
- (void)createNewAddressButtonDidPress;
@end

@implementation UserAddressesViewController

#pragma mark -
#pragma mark Initializations

- (id)initWithAddresses:(NSMutableArray *)addresses {
  self = [super init];
  if ( self ) {
    self.title = @"Addresses";
    __addresses = [addresses retain];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewAddressButtonDidPress)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteAddressNotification:) name:kDeleteButtonDidPressNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editAddressNotification:) name:kEditButtonDidPressNotification object:nil];    
  }
  
  return self;
}

#pragma mark -
#pragma mark Lifecycle

- (void)loadView {
  [super loadView];
  
  __userAddressesView = [[UserAddressesView alloc] init];
  self.view = __userAddressesView;  
  [self createModel];
}

- (void)viewDidUnload {
  [super viewDidUnload];
  
  [self releaseWithDealloc:NO];
}

#pragma mark -
#pragma mark Memory management

- (void)releaseWithDealloc:(BOOL)dealloc {
  OI_RELEASE_SAFELY( __userAddressesView );
  if ( dealloc ) {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDeleteButtonDidPressNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kEditButtonDidPressNotification object:nil];    
    OI_RELEASE_SAFELY( __userAddressesDataSource );
    OI_RELEASE_SAFELY( __addresses );
  }  
}

- (void)dealloc {
  [self releaseWithDealloc:YES];
  [super dealloc];
}

@end

#pragma mark -
#pragma mark Private

@implementation UserAddressesViewController (Private)

- (void)deleteAddressNotification:(NSNotification *)notification {
  NSNumber *section = [notification.userInfo objectForKey:@"section"];
  OIAddress *address = [__userAddressesDataSource.addresses objectAtIndex:section.integerValue];
  [OIAddress deleteAddressByNickname:address.nickname usingBlock:^void( NSError *error ) {
    if ( error ) {
      
    }
  }];
  
  NSLog( @"deleteAddressNotification %d", section.integerValue );
}

- (void)editAddressNotification:(NSNotification *)notification {
  NSNumber *section = [notification.userInfo objectForKey:@"section"];
  NSLog( @"editAddressNotification %d", section.integerValue );
}

- (void)createNewAddressButtonDidPress {
  AddAddressViewController *addAddressViewController = [[AddAddressViewController alloc] init];
  [self.navigationController pushViewController:addAddressViewController animated:YES];
  OI_RELEASE_SAFELY( addAddressViewController );
}

- (void)createModel {
  __userAddressesDataSource = [[UserAddressesDataSource alloc] initWithAddresses:__addresses];
  __userAddressesView.tableView.dataSource = __userAddressesDataSource;
}

@end
