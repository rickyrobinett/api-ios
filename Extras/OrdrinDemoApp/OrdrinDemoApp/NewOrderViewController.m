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

#import "NewOrderViewController.h"
#import "NewOrderView.h"
#import "OICore.h"
#import "OIOrder.h"
#import "NewOrderModel.h"
#import "OIAddress.h"

@interface NewOrderViewController (Private)
- (void)restaurantsButtonDidPress;
- (void)saveButtonDidPress;
- (void)createModel;
@end

@implementation NewOrderViewController

#pragma mark -
#pragma mark Initializations

- (id)initWithAddress:(OIAddress *)address {
  self = [super init];
  if ( self ) {
    self.title = @"New order";
    __address = [address retain];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonDidPress)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    OI_RELEASE_SAFELY( saveButton );
  }  
  return self;
}

#pragma mark -
#pragma mark Lifecycles

- (void)loadView {
  [super loadView];
  
  __newOrderView = [[NewOrderView alloc] init];
  [__newOrderView.restaurantsButton addTarget:self action:@selector(restaurantsButtonDidPress) forControlEvents:UIControlEventTouchDown];  
  self.view = __newOrderView;
  [self createModel];
}

- (void)viewDidUnload {
  [super viewDidUnload];
  
  [self releaseWithDealloc:NO];
}

#pragma mark -
#pragma mark Memory management

- (void)releaseWithDealloc:(BOOL)dealloc {   
  OI_RELEASE_SAFELY( __newOrderView );
  if ( dealloc ) {
    OI_RELEASE_SAFELY( __address );
    OI_RELEASE_SAFELY( __newOrderModel );    
  }  
}

- (void)dealloc {
  [self releaseWithDealloc:YES];
  [super dealloc];
}

@end

#pragma mark -
#pragma mark Private

@implementation NewOrderViewController (Private)

- (void)restaurantsButtonDidPress {
  UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController:nil];
  [popoverController presentPopoverFromRect:CGRectZero inView:__newOrderView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (void)createModel {
  __newOrderModel = [[NewOrderModel alloc] initWithAddress:__address];
}

- (void)saveButtonDidPress {
  OIOrder *order = [[OIOrder alloc] init];
  [order orderForUser:nil atAddress:nil withCard:nil usingBlock:^void( NSError *error ) {
    
  }];
}

@end