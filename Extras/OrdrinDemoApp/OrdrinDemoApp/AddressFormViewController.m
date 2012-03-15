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

#import "AddressFormViewController.h"
#import "AddressFormView.h"
#import "OIAddress.h"
#import "OICore.h"
#import "RestaurantListViewController.h"

@interface AddressFormViewController (Private)
- (void)hideKeyboard;
- (void)findButtonDidPress;
@end

@implementation AddressFormViewController

#pragma mark -
#pragma mark Initializations

- (id)init {
  self = [super init];  
  if ( self ) {
    self.title = @"Address";
  }  
  return self;
}

#pragma mark -
#pragma mark Lifecycles

- (void)loadView {
  [super loadView];
  
  __addressFormView = [[AddressFormView alloc] init];
  [__addressFormView.findButton addTarget:self action:@selector(findButtonDidPress) forControlEvents:UIControlEventTouchDown];
  
  self.view = __addressFormView;
}

- (void)viewDidUnload {
  [super viewDidUnload];
  
  [self releaseWithDealloc:NO];
}

#pragma mark -
#pragma mark Events

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [self hideKeyboard];
}

#pragma mark -
#pragma mark Memory management

- (void)releaseWithDealloc:(BOOL)dealloc {  
  OI_RELEASE_SAFELY( __addressFormView );  
  if ( dealloc ) {    
  }  
}

- (void)dealloc {
  [self releaseWithDealloc:YES];
  
  [super dealloc];
}
@end

#pragma mark -
#pragma mark Private

@implementation AddressFormViewController (Private)

- (void)findButtonDidPress {
//  NSString *street = @"1 Main St";
//  NSString *city = @"College Station";
//  NSString *postalCodeStr = @"77840";

  NSString *street = __addressFormView.streetField.text;
  NSString *city = __addressFormView.cityField.text;
  NSString *postalCodeStr = __addressFormView.postalCodeField.text;
  
  if ( !street || !city || !postalCodeStr ) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please fill all fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    OI_RELEASE_SAFELY( alert );
    
    return;        
  }
  
  OIAddress *address = [OIAddress addressWithStreet:street
                                               city:city
                                         postalCode:[NSNumber numberWithInt:postalCodeStr.intValue]];
  
  RestaurantListViewController *restaurantListViewController = [[RestaurantListViewController alloc] initWithAddress:address];
  restaurantListViewController.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:restaurantListViewController animated:YES];
  
  OI_RELEASE_SAFELY( restaurantListViewController );
}

- (void)hideKeyboard {
  [__addressFormView.cityField resignFirstResponder];
  [__addressFormView.postalCodeField resignFirstResponder];
  [__addressFormView.streetField resignFirstResponder];
}
@end
