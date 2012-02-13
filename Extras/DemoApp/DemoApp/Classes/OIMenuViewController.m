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
#import "OIMenuViewController.h"
#import "OIListViewController.h"
#import "OIOrderViewController.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Interface

@interface OIMenuViewController()< UITableViewDelegate, UITableViewDataSource >
@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Implementation

@implementation OIMenuViewController {
@private
  UITableView *__tableView;
}

#pragma mark -
#pragma mark Lifecycle

- (void)loadView {
  [super loadView];
  
  __tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
  __tableView.delegate = self;
  __tableView.dataSource = self;
  [self.view addSubview:__tableView];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
  if ( ! cell ) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] autorelease];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  }
  
  switch (indexPath.row) {
    case 0:
      cell.textLabel.text = NSLocalizedString( @"Restaurants", "" );
      break;
      
    case 1:
      cell.textLabel.text = NSLocalizedString( @"Order", "" );
      break;
  }
  
  return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  if ( indexPath.row == 0 ) {
    OIListViewController *list = [[OIListViewController alloc] init];
    [self.navigationController pushViewController:list animated:YES];
    [list release];
  }
  else if ( indexPath.row == 1 ) {
    OIOrderViewController *order = [[OIOrderViewController alloc] init];
    [self.navigationController pushViewController:order animated:YES];
    [order release];
  }
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __tableView );
  
  [super dealloc];
}

@end
