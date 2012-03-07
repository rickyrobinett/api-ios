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

#import "AccountInfoDataSource.h"
#import "OIUserInfo.h"

static NSString *cellIdentifier = @"AccountInfoCell";

@implementation AccountInfoDataSource

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if ( !cell ) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
  }

  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
  
  OIUserInfo *userInfo = [OIUserInfo sharedInstance];
  
  switch (indexPath.row) {
    case 0:
      cell.textLabel.text = [NSString stringWithFormat:@"First Name: %@", userInfo.firstName];
      break;
      
    case 1:
      cell.textLabel.text = [NSString stringWithFormat:@"Last Name: %@", userInfo.lastName];
      break;
      
    case 2:
      cell.textLabel.text = [NSString stringWithFormat:@"Email: %@", userInfo.email];
      break;
  }
  
  return cell;
}

@end
