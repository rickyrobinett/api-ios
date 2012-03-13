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

#import <UIKit/UIKit.h>

@class OrderTableView;
@class OrderCardsDataSource;

@protocol OrderCardsDelegate <NSObject>
- (void)creditCardDidSelect:(NSUInteger)index;
@end

@interface OrderCardsViewController : UIViewController<UITableViewDelegate> {
  
@private
  id<OrderCardsDelegate> __delegate;
  OrderTableView *__cardsView;
  OrderCardsDataSource *__dataSource;
  NSArray *__creditCards;
}

- (id)initWithCreditCards:(NSArray *)creditCards;
@property (nonatomic, retain) id<OrderCardsDelegate> delegate;

@end
