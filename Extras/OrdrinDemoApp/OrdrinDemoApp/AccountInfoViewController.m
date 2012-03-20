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

#import "AccountInfoViewController.h"
#import "AccountInfoView.h"
#import "OICore.h"
#import "AccountInfoDataSource.h"

@interface AccountInfoViewController (Private)
- (void)createModel;
@end

@implementation AccountInfoViewController

#pragma mark -
#pragma mark Initializations

- (id)init {
  self = [super init];
  if ( self ) {
    self.title = @"Account info";
  }
  
  return self;
}

#pragma mark -
#pragma mark Lifecycles

- (void)loadView {
  [super loadView];
  
  __accountInfoView = [[AccountInfoView alloc] init];
  self.view = __accountInfoView;
  [self createModel];
}

- (void)viewDidUnload {
  [super viewDidUnload];
  
  [self releaseWithDealloc:NO];
}

#pragma mark -
#pragma mark Memory management

- (void)releaseWithDealloc:(BOOL)dealloc {
  OI_RELEASE_SAFELY( __accountInfoView );
  if ( dealloc ) {
    OI_RELEASE_SAFELY( __accountInfoDataSource );    
  }  
}

- (void)dealloc {
  [self releaseWithDealloc:YES];
  [super dealloc];
}

@end

#pragma mark -
#pragma mark Private

@implementation AccountInfoViewController (Private)

- (void)createModel {
  __accountInfoDataSource = [[AccountInfoDataSource alloc] init];
  __accountInfoView.tableView.dataSource = __accountInfoDataSource;
}

@end