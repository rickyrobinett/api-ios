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

#import "UserCreditCardsDataSource.h"
#import "OICardInfo.h"
#import "OICore.h"
#import "OIAddress.h"
#import "UserCreditCardsModel.h"
#import "TextViewCell.h"
#import "ActionViewCell.h"

static NSString *cellTextIdentifier = @"cellCreditCardsTextIdentifier";
static NSString *cellActionIdentifier = @"cellCreditCardsActionIdentifier";

@implementation UserCreditCardsDataSource

@synthesize model = __model;

#pragma mark -
#pragma mark Initializations

- (id)init {
  self = [super init];
  if ( self ) {
    __model = [[UserCreditCardsModel alloc] init];
  }
  
  return self;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  OICardInfo *cardInfo = [__model.items objectAtIndex:indexPath.section];
  
  if ( indexPath.row < 5 ) {
    TextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTextIdentifier];
    
    if ( !cell ) {
      cell = [[[TextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTextIdentifier] autorelease];
    }            
    if( cardInfo ) {      
      switch ( indexPath.row ) {
        case 0: 
          [cell setTitle:[NSString stringWithFormat:@"Nickname: %@", cardInfo.nickname]];
          break;
        case 1:
          [cell setTitle:[NSString stringWithFormat:@"Name: %@", cardInfo.name]];
          break;  
        case 2:
          [cell setTitle:[NSString stringWithFormat:@"Last Five Digits: %@", cardInfo.lastFiveDigits]];
          break;       
        case 3:
          [cell setTitle:[NSString stringWithFormat:@"Type: %@", cardInfo.type]];
          break;   
        case 4:
          [cell setTitle:[NSString stringWithFormat:@"Expiration: %@ / %@", cardInfo.expirationMonth, cardInfo.expirationYear]];
          break; 
      }
    }
    return cell;  
  } else {
    ActionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellActionIdentifier];      
    if ( !cell ) {
      cell = [[[ActionViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellActionIdentifier] autorelease];
    }    
    cell.section = indexPath.section;
    return cell;    
  }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return __model.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {  
  return 6;
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  OI_RELEASE_SAFELY( __model );
  [super dealloc];
}

@end
