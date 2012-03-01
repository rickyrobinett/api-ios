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

@class OIAddress;

@interface OICardInfo : NSObject

@property (nonatomic, readwrite, copy) NSString *nickname;
@property (nonatomic, readwrite, copy) NSString *name;
@property (nonatomic, readwrite, retain) NSNumber *number;
@property (nonatomic, readwrite, retain) NSNumber *cvc;
@property (nonatomic, readwrite, retain) NSNumber *lastFiveDigits;
@property (nonatomic, readwrite, copy) NSString *type;
@property (nonatomic, readwrite, copy) NSString *expirationMonth;
@property (nonatomic, readwrite, copy) NSString *expirationYear;
@property (nonatomic, readwrite, retain) OIAddress *address;

#pragma mark -
#pragma mark Class methods

/**
 * Load all user credit cards.
 * 
 * @param block
 * Block return all user credit cards.
 */
+ (void)loadCreditCardsUsingBlock:(void (^)(NSMutableArray *creditCards))block;

/**
 * Load user credit card (OICardInfo) by its nickname.
 *
 * @param nickname
 * The nickname of the searching credit card.
 *
 * @param block
 * Block return credit card (OICardInfo) with required nickname.
 */
+ (void)loadCreditCardByNickname:(NSString *)nickname usingBlock:(void (^)(OICardInfo *cardInfo))block;

+ (void)deleteCreditCardByNickname:(NSString *)nickname usingBlock:(void (^)(NSError *error))block;
@end
