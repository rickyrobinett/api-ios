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
#import "UserAddressTextCell.h"
#import "UserAddressEditCell.h"
#import "UserAddressesModel.h"

static NSString *cellTextIdentifier = @"cellTextIdentifier";
static NSString *cellEditIdentifier = @"cellEditIdentifier";

@implementation UserAddressesDataSource

@synthesize model = __model;

#pragma mark -
#pragma mark Initializations

- (id)init {
  self = [super init];
  if ( self ) {
    __model = [[UserAddressesModel alloc] init];
  }
  
  return self;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {  
  return __model.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {  
  return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  OIAddress *address = [__model.items objectAtIndex:indexPath.section];

  if ( indexPath.row < 7 ) {
    UserAddressTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTextIdentifier];      
    if ( !cell ) {
      cell = [[[UserAddressTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTextIdentifier] autorelease];
    }
    
    if( address ) {    
      switch ( indexPath.row ) {
        case 0: 
          [cell setTitle:[NSString stringWithFormat:@"Nickname: %@", address.nickname]];
          break;
        case 1:
          [cell setTitle:[NSString stringWithFormat:@"Street 1: %@", address.address1]];          
          break;
        case 2:
          [cell setTitle:[NSString stringWithFormat:@"Street 2: %@", address.address2]];          
          break;   
        case 3:
          [cell setTitle:[NSString stringWithFormat:@"City: %@", address.city]];                    
          break;  
        case 4:
          [cell setTitle:[NSString stringWithFormat:@"State: %@", address.state]];                    
          break;       
        case 5:
          [cell setTitle:[NSString stringWithFormat:@"Zip Code: %@", address.postalCode]];                    
          break;   
        case 6:
          [cell setTitle:[NSString stringWithFormat:@"Phone Number: %@", address.phoneNumber]];                    
          break; 
      }
    }
    return cell;
  } else {
    UserAddressEditCell *cell = [tableView dequeueReusableCellWithIdentifier:cellEditIdentifier];      
    if ( !cell ) {
      cell = [[[UserAddressEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellEditIdentifier] autorelease];
    }
    
    cell.section = indexPath.section;
    return cell;
  }
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  OI_RELEASE_SAFELY( __model );
  [super dealloc];
}

@end
