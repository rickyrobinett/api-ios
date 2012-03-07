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
  NSArray *__addresses;
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
  
  //UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
  //[footerView addSubview:buttonNewAddress];
  
  //__tableView.tableFooterView = footerView; 
  //[footerView release];
  
  [self.view addSubview:__tableView];
  
  [OIAddress loadAddressesUsingBlock:^void( NSMutableArray *addresses) {
    
    if ( addresses && addresses.count > 0 ) {
      OI_RELEASE_SAFELY( __addresses );
      __addresses = [addresses retain];
      [self reload];      
    } else {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot load user addresses." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]; 
      [alert show];
      [alert release];            
    }
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
  
  if(address) {
    
    switch (indexPath.row) {
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

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//
//    return 100.0f;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//  
//}

-(void)buttonNewAddressPressed {
  OIUserNewAddressViewController *controller = [[OIUserNewAddressViewController alloc] init];
  [self.navigationController pushViewController:controller animated:YES];
  [controller release];  
}

#pragma mark -
#pragma mark Memory Management

- (void)releaseWithDealloc:(BOOL)dealloc {
  [__tableView release], __tableView = nil;
  
  if ( dealloc ) {
    [__addresses release], __addresses = nil;
  }
}

- (void)viewDidUnload {
  [self releaseWithDealloc:NO];
  [super viewDidUnload];
}

- (void)dealloc {
  [self releaseWithDealloc:YES];
  [super dealloc];
}
@end
