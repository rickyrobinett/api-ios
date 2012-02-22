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

#import "OIUserAccountSettingsViewController.h"
#import "OIApplicationData.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Interface

@interface OIUserAccountSettingsViewController()< UITableViewDataSource, UITableViewDelegate >

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Implementation

@implementation OIUserAccountSettingsViewController {
@private
  UITableView *__tableView;
}

#pragma mark -
#pragma mark Lifecycle

- (void)loadView {
  [super loadView];
  
  self.title = NSLocalizedString( @"Account Info", "" );
  
  __tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
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
  return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
  if ( ! cell ) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] autorelease];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
  }
  
  OIApplicationData *appDataManager = [OIApplicationData sharedInstance];
  
  switch (indexPath.row) {
    case 0:
      cell.textLabel.text = [NSString stringWithFormat:@"First Name: %@", [[appDataManager currentUser] firstName]];
      break;
      
    case 1:
      cell.textLabel.text = [NSString stringWithFormat:@"Last Name: %@", [[appDataManager currentUser] lastName]];
      break;
      
    case 2:
      cell.textLabel.text = [NSString stringWithFormat:@"Email: %@", [[appDataManager currentUser] email]];
      break;
  }
  
  return cell;
  
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __tableView );
  [super dealloc];
}

@end
