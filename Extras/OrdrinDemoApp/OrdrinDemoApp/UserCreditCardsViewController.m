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
#import "AddCreditCardViewController.h"
#import "OICore.h"
#import "UserCreditCardsModel.h"
#import "TextViewCell.h"
#import "ActionViewCell.h"
#import "OICardInfo.h"
#import "EditCreditCardViewController.h"

@interface UserCreditCardsViewController (Private)
- (void)deleteAddressNotification:(NSNotification *)notification;
- (void)editAddressNotification:(NSNotification *)notification;
- (void)creditCardsDidLoadNotification:(NSNotification *)notification;

- (void)createModel;
- (void)createNewCreaditCard;
@end

@implementation UserCreditCardsViewController

#pragma mark -
#pragma mark Initializations

- (id)init {
  self = [super init];
  if ( self ) {
    self.title = @"Credit cards";
    
    UIBarButtonItem *createButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewCreaditCard)];
    self.navigationItem.rightBarButtonItem = createButtonItem;
    
    OI_RELEASE_SAFELY( createButtonItem );

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteAddressNotification:) name:kDeleteButtonDidPressNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editAddressNotification:) name:kEditButtonDidPressNotification object:nil];        
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(creditCardsDidLoadNotification:) name:kCreditCardsDidLoadNotification object:nil];
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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDeleteButtonDidPressNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kEditButtonDidPressNotification object:nil];        
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kCreditCardsDidLoadNotification object:nil];
    OI_RELEASE_SAFELY( __userCreditCardsDataSource );    
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

- (void)deleteAddressNotification:(NSNotification *)notification {
  NSNumber *section = [notification.userInfo objectForKey:@"section"];
  OICardInfo *creditCard = [__userCreditCardsDataSource.model.items objectAtIndex:section.integerValue];
  [OICardInfo deleteCreditCardByNickname:creditCard.nickname usingBlock:^void( NSError *error ) {
    if ( error ) {
      
    } else {
      [__userCreditCardsDataSource.model reload];      
    }
  }];
}

- (void)editAddressNotification:(NSNotification *)notification {
  NSNumber *section = [notification.userInfo objectForKey:@"section"];
  OICardInfo *creditCard = [__userCreditCardsDataSource.model.items objectAtIndex:section.integerValue];
  EditCreditCardViewController *editCreditCardViewController = [[EditCreditCardViewController alloc] initWithCardInfo:creditCard];
  editCreditCardViewController.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:editCreditCardViewController animated:YES];
  
  OI_RELEASE_SAFELY( editCreditCardViewController );
}

- (void)creditCardsDidLoadNotification:(NSNotification *)notification {
  [__userCreditCardsView.tableView reloadData];
}

- (void)createNewCreaditCard {
  AddCreditCardViewController *addCreditCardViewController = [[AddCreditCardViewController alloc] init];
  addCreditCardViewController.hidesBottomBarWhenPushed = YES;
  [self.navigationController pushViewController:addCreditCardViewController animated:YES];
  OI_RELEASE_SAFELY( addCreditCardViewController );
}

- (void)createModel {
  __userCreditCardsDataSource = [[UserCreditCardsDataSource alloc] init];
  __userCreditCardsView.tableView.dataSource = __userCreditCardsDataSource;
}

@end

