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

#import "MenuItemsDataSource.h"
#import "OICore.h"
#import "TextViewCell.h"
#import "OIMenuItem.h"

static NSString *cellIdentifier = @"menuItemCellIdentifier";
static NSString *cellWithButtonIdentifier = @"cellWithButtonIdentifier";

@implementation MenuItemsDataSource

@synthesize menuItems = __menuItems;

#pragma mark -
#pragma mark Initializations

- (id)initWithMenuItems:(NSMutableArray *)menuItems {
  self = [super init];
  if ( self ) {
    __menuItems = [menuItems retain];    
  }
  
  return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  OIMenuItem *menuItem = [__menuItems objectAtIndex:indexPath.section];
  TextViewCell *cell;
  NSString *identifier;
  UITableViewCellAccessoryType accessoryType;
  if ( indexPath.row == 0 ) {
    accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    identifier = cellWithButtonIdentifier;
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];    
  } else {
    accessoryType = UITableViewCellAccessoryNone;    
    identifier = cellIdentifier;    
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];        
  }
    
  if ( !cell ) {
    cell = [[[TextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    cell.accessoryType = accessoryType;
  }
  
  switch ( indexPath.row ) {
    case 0:[cell setTitle:[NSString stringWithFormat:@"Name: %@",menuItem.name]]; 
      break;
    case 1:[cell setTitle:[NSString stringWithFormat:@"Description: %@",menuItem.description]];
      break;
    case 2:[cell setTitle:[NSString stringWithFormat:@"Price: %@",menuItem.price]];
      break;
    case 3:[cell setTitle:[NSString stringWithFormat:@"ID: %@",menuItem.ID]];
      break;      
  }
  
  return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return __menuItems.count;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  OI_RELEASE_SAFELY( __menuItems );
  [super dealloc];
}

@end
