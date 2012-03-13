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

@interface NewOrderViewController (Private)
- (void)saveButtonDidPress;
@end

@implementation NewOrderViewController

#pragma mark -
#pragma mark Initializations

- (id)init {
  self = [super init];
  if ( self ) {
    self.title = @"New order";
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
}

@end

#pragma mark -
#pragma mark Private

@implementation NewOrderViewController (Private)

- (void)saveButtonDidPress {
//  OIOrder 
}

@end