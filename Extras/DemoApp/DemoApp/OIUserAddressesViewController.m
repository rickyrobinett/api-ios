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

#import "OIUserAddressesViewController.h"
#import "OIApplicationData.h"
#import "OIUserNewAddressViewController.h"
#import "OIUserAccountSettingsViewController.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Interface

@interface OIUserAddressesViewController()< UITableViewDataSource, UITableViewDelegate >

- (void)reload;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Implementation

@implementation OIUserAddressesViewController {
@private
  UITableView *__tableView;
}

#pragma mark -
#pragma mark - View lifecycle

- (void)loadView {
  [super loadView];
  
  self.title = NSLocalizedString( @"Addresses", "" );
  
  __tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
  __tableView.delegate = self;
  __tableView.dataSource = self;
  
  UIButton *buttonNewAddress = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  buttonNewAddress.frame = CGRectMake(35, 5, 250, 30);
  [buttonNewAddress setTitle:@"Add New Address" forState:UIControlStateNormal];
  [buttonNewAddress addTarget:self action:@selector(buttonNewAddressPressed) forControlEvents:UIControlEventTouchUpInside]; 
  
  UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
  [footerView addSubview:buttonNewAddress];
  
  __tableView.tableFooterView = footerView; 
  [footerView release];
  
  [self.view addSubview:__tableView];
  
  [[[OIApplicationData sharedInstance] currentUser] loadAddressesUsingBlock:^void (NSError *error) {
    
    if(error) {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot load user addresses." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]; 
      [alert show];
      [alert release];      
    }
    else
      [self reload];
  }];
}


#pragma mark -
#pragma mark Private

- (void)reload {
  if ( [NSThread isMainThread] ) {
    [__tableView reloadData];    
  }
  else {
    dispatch_sync(dispatch_get_main_queue(), ^void() {
      [__tableView reloadData];
    });
  }
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  
  return [[[[OIApplicationData sharedInstance] currentUser] addresses] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
  
  if ( ! cell ) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] autorelease];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
  }
  
  return cell;
}


-(void)buttonNewAddressPressed {
  OIUserNewAddressViewController *controller = [[OIUserNewAddressViewController alloc] init];
  [self.navigationController pushViewController:controller animated:YES];
  [controller release];  
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __tableView );
  
  [super dealloc];
}
@end
