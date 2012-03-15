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

#import <Foundation/Foundation.h>

extern NSString *const OIOrderBaseURL;

@class OIUser;
@class OIAddress;
@class OICardInfo;
@class OIRestaurantBase;

@interface OIOrder : NSObject
#warning Dopsat komenty
/// Ordr.in's reference number for that order.
@property (nonatomic, readwrite, copy) NSString *orderID;
/// Ordr.in's restaurant identifier.
@property (nonatomic, readwrite, retain) NSNumber *total;
/// Base informtion about restaurant.
@property (nonatomic, readwrite, retain) OIRestaurantBase *restaurantBase;
/// Amount of tip in dollars and cents.
@property (nonatomic, readwrite, retain) NSNumber *tip;
/// Either ASAP or in the date format 2 digit month - 2 digit date (i.e. January 21 would be 01-21)
@property (nonatomic, readwrite, retain) NSDate *date;
///
@property (nonatomic, readwrite, retain) NSArray *items;

#pragma mark -
#pragma mark Class methods

/**
 *
 *
 */
+ (void)createOrderWithRestaurantId:(NSString *)restaurantID atAddress:(OIAddress*)address withCard:(OICardInfo *)card date:(NSDate *)date orderItems:(NSString *)orderItems tip:(NSNumber *)tip usingBlock:(void (^)(NSError *error))block;
/**
 * Load all user orders.
 *
 * @param block
 * Block return orders.
 */
+ (void)loadOrderHistoryUsingBlock:(void (^)(NSMutableArray *orders))block;

/**
 * Load user order by its ID.
 *
 * @param ID
 * Ordr.in's reference number for that order.
 *
 * @param block (OIOrder)
 * Block return user order.
 */
+ (void)loadOrderByID:(NSString *)ID usingBlock:(void (^)(OIOrder *order))block;
@end
