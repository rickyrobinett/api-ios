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

#import "UserAddressesDataSource.h"
#import "OICore.h"
#import "OIAddress.h"
@implementation UserAddressesDataSource

#pragma mark -
#pragma mark Initializations

- (id)initWithAddresses:(NSMutableArray *)addresses {
  self = [super init];
  if ( self ) {
    __addresses = [addresses retain];    
  }
  
  return self;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {  
  return __addresses.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {  
  return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
  
  if ( ! cell ) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] autorelease];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
  }
  
  OIAddress *address = [__addresses objectAtIndex:indexPath.section];
  
  if( address ) {    
    switch ( indexPath.row ) {
      case 0: 
        cell.textLabel.text = [NSString stringWithFormat:@"Nickname: %@", address.nickname];
        break;
      case 1:
        cell.textLabel.text = [NSString stringWithFormat:@"Street 1: %@", address.address1];
        break;
      case 2:
        cell.textLabel.text = [NSString stringWithFormat:@"Street 2: %@", address.address2];
        break;   
      case 3:
        cell.textLabel.text = [NSString stringWithFormat:@"City: %@", address.city];
        break;  
      case 4:
        cell.textLabel.text = [NSString stringWithFormat:@"State: %@", address.state];
        break;       
      case 5:
        cell.textLabel.text = [NSString stringWithFormat:@"Zip Code: %@", address.postalCode];
        break;   
      case 6:
        cell.textLabel.text = [NSString stringWithFormat:@"Phone Number: %@", address.phoneNumber];
        break; 
      case 7: {
        UIButton *buttonEdit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        buttonEdit.frame = CGRectMake(15, 7, 70, 30);
        [buttonEdit setTitle:@"Edit" forState:UIControlStateNormal];
        
        UIButton *buttonDelete = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        buttonDelete.frame = CGRectMake(235, 7, 70, 30);
        [buttonDelete setTitle:@"Delete" forState:UIControlStateNormal];
        
        [cell addSubview:buttonEdit];
        [cell addSubview:buttonDelete];
      }
        break;     
    }
  }
  return cell;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  OI_RELEASE_SAFELY( __addresses );
  [super dealloc];
}

@end
