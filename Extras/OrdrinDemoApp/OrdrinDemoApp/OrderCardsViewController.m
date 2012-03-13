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

#import "OrderCardsViewController.h"
#import "OICore.h"
#import "OrderTableView.h"
#import "OrderCardsDataSource.h"

@interface OrderCardsViewController (Private)
- (void)createModel;
@end

@implementation OrderCardsViewController

@synthesize delegate = __delegate;

#pragma mark -
#pragma mark Initializations

- (id)initWithCreditCards:(NSArray *)creditCards {
  self = [super init];
  if ( self ) {
    __creditCards = [creditCards retain];
  }
  
  return self;
}

#pragma mark -
#pragma mark Lifecycles

- (void)loadView {
  [super loadView];
  
  __cardsView = [[OrderTableView alloc] init];
  self.view = __cardsView;
  
  [self createModel];
}

- (void)viewDidUnload {
  [super viewDidUnload];
  [self releaseWithDealloc:NO];
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [__delegate creditCardDidSelect:indexPath.row];
  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Memory anagement

- (void)releaseWithDealloc:(BOOL)dealloc {
  OI_RELEASE_SAFELY( __cardsView );
  if ( dealloc ) {
    OI_RELEASE_SAFELY( __dataSource );
    OI_RELEASE_SAFELY( __creditCards );    
    __delegate = nil;
  }
}

- (void)dealloc {
  [self releaseWithDealloc:YES];
  [super dealloc];
}

@end

#pragma mark -
#pragma mark Private

@implementation OrderCardsViewController (Private)

- (void)createModel {
  __dataSource = [[OrderCardsDataSource alloc] initWithCreditCards:__creditCards];
  __cardsView.tableView.dataSource = __dataSource;
  __cardsView.tableView.delegate = self;  
}

@end
