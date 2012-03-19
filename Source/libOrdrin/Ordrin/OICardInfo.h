/*
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

/**
 * Class contain informations about user credit card.
 */
#import <Foundation/Foundation.h>

@class OIAddress;

@interface OICardInfo : NSObject

/// The nickname of the card.
@property (nonatomic, readwrite, copy) NSString *nickname;
/// The name on the card.
@property (nonatomic, readwrite, copy) NSString *name;
/// The 15 or 16 digit credit card number, no spaces or punctuation.
@property (nonatomic, readwrite, copy) NSString *number;
/// The 3 or 4 digit security code.
@property (nonatomic, readwrite, retain) NSNumber *cvc;
/// The last 5 digits of the card.
@property (nonatomic, readwrite, retain) NSNumber *lastFiveDigits;
/// The type of card (i.e. American Express).
@property (nonatomic, readwrite, copy) NSString *type;
/// The 2 digit expiry month (i.e. 01 = January, 12 = December).
@property (nonatomic, readwrite, copy) NSString *expirationMonth;
/// The 4 digit expiry year.
@property (nonatomic, readwrite, copy) NSString *expirationYear;
/// The billing address (OIAddress).
@property (nonatomic, readwrite, retain) OIAddress *address;

#pragma mark -
#pragma mark Class methods

/**
 * Add credit card (OICardInfo) to the server and to the credit cards of the 
 * user (OIUser).
 * 
 * @param address New credit card (OICardInfo) which will be added to the user credit cards (server, application).
 *
 * @param block Block return nil if request finished successfully.
 */
+ (void)addCreditCard:(OICardInfo *)creditCard usingBlock:(void (^)(NSError *error))block;

/**
 * Update credit card info.
 *
 * @param creditCard Changed credit card (OICardInfo), which will replace previous credit card.
 *
 * @param block Block return nil if request finished successfully.
 */
- (void)updateCreditCardWithCard:(OICardInfo *)creditCard usingBlock:(void (^)(NSError *error))block;

/**
 * Load all user credit cards.
 * 
 * @param block Block return all user credit cards.
 */
+ (void)loadCreditCardsUsingBlock:(void (^)(NSMutableArray *creditCards))block;

/**
 * Load user credit card (OICardInfo) by its nickname.
 *
 * @param nickname The nickname of the searching credit card.
 *
 * @param block Block return credit card (OICardInfo) with required nickname.
 */
+ (void)loadCreditCardByNickname:(NSString *)nickname usingBlock:(void (^)(OICardInfo *cardInfo))block;

/**
 * Delete user credit card by its nickname.
 *
 * @param nickname The nick name of the credit card, which will be deleted.
 *
 * @param block Block return nil if request finished successfully.
 */
+ (void)deleteCreditCardByNickname:(NSString *)nickname usingBlock:(void (^)(NSError *error))block;
@end
