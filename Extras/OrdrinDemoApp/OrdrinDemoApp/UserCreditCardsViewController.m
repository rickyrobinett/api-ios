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

#import "UserCreditCardsViewController.h"
#import "UserCreditCardsView.h"
#import "UserCreditCardsDataSource.h"
#import "OICore.h"

@interface UserCreditCardsViewController (Private)
- (void)createModel;
- (void)createNewCreaditCard;
@end

@implementation UserCreditCardsViewController

#pragma mark -
#pragma mark Initializations

- (id)initWithCreditCards:(NSMutableArray *)creditCards {
  self = [super init];
  if ( self ) {
    self.title = @"Credit cards";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewCreaditCard)];
    __creditCards = [creditCards retain];
  }
  
  return self;
}

#pragma mark -
#pragma mark Lifecycle

- (void)loadView {
  [super loadView];
  
  __userCreditCardsView = [[UserCreditCardsView alloc] init];
  self.view = __userCreditCardsView;
  [self createModel];
}

- (void)viewDidUnload {
  [super viewDidUnload];
  
  [self releaseWithDealloc:NO];
}

#pragma mark -
#pragma mark Memory management

- (void)releaseWithDealloc:(BOOL)dealloc {
  OI_RELEASE_SAFELY( __userCreditCardsView );
  if ( dealloc ) {
    OI_RELEASE_SAFELY( __userCreditCardsDataSource );    
    OI_RELEASE_SAFELY( __creditCards );
  }  
}

- (void)dealloc {
  [self releaseWithDealloc:YES];
  [super dealloc];
}

@end

#pragma mark -
#pragma mark Private

@implementation UserCreditCardsViewController (Private)

- (void)createNewCreaditCard {

}

- (void)createModel {
  __userCreditCardsDataSource = [[UserCreditCardsDataSource alloc] initWithCreditCards:__creditCards];
  __userCreditCardsView.tableView.dataSource = __userCreditCardsDataSource;
}

@end

