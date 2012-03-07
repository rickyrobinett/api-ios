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

static NSString *cellIdentifier = @"userCreaditCardCell";

@implementation UserCreditCardsDataSource

#pragma mark -
#pragma mark Initializations

- (id)initWithCreditCards:(NSMutableArray *)creditCards {
  self = [super init];
  if ( self ) {
    __creditCards = [creditCards retain];
  }
  
  return self;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if ( !cell ) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
  }
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
  
  OICardInfo *cardInfo = [__creditCards objectAtIndex:indexPath.section];
  
  if( cardInfo ) {
    
    switch ( indexPath.row ) {
      case 0: 
        cell.textLabel.text = [NSString stringWithFormat:@"Nickname: %@", cardInfo.nickname];
        break;
      case 1:
        cell.textLabel.text = [NSString stringWithFormat:@"Name: %@", cardInfo.name];
        break;
      case 2:
        cell.textLabel.text = [NSString stringWithFormat:@"Number: %@", cardInfo.number];
        break;   
      case 3:
        cell.textLabel.text = [NSString stringWithFormat:@"Cvc: %@", cardInfo.cvc];
        break;  
      case 4:
        cell.textLabel.text = [NSString stringWithFormat:@"Last Five Digits: %@", cardInfo.lastFiveDigits];
        break;       
      case 5:
        cell.textLabel.text = [NSString stringWithFormat:@"Type: %@", cardInfo.type];
        break;   
      case 6:
        cell.textLabel.text = [NSString stringWithFormat:@"Expiration: %@ / %@", cardInfo.expirationMonth, cardInfo.expirationYear];
        break; 
    }
  }
  return cell;  
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return __creditCards.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {  
  return 7;
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  OI_RELEASE_SAFELY( __creditCards );
  
  [super dealloc];
}

@end
