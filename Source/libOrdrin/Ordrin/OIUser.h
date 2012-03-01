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

extern NSString const* OIUserBaseURL;

@class OIAddress;
@class OICardInfo;
@class OIOrder;

@interface OIUser : NSObject

@property (nonatomic, readwrite, copy) NSString *firstName;
@property (nonatomic, readwrite, copy) NSString *lastName;
@property (nonatomic, readwrite, retain) NSArray *addresses;
@property (nonatomic, readwrite, retain) NSArray *creditCards;
@property (nonatomic, readwrite, retain) NSArray *orders;

#pragma mark -
#pragma mark Instance methods

/**
 * Load all user addresses into the OIUser instance. Call block with nil parameter 
 * if succeeded or with a request error if failed
 */
- (void)loadAddressesUsingBlock:(void (^)(NSError *error))block;

/**
 * Load user address by its nickname. Call block with created OIAddress instance if succeeded 
 * or with nil if failed
 */
- (void)loadAddressByNickname:(NSString *)nickname usingBlock:(void (^)(OIAddress *address))block;

/**
 * Change user address (overwrite) or add if it doesn't exist. Call block with nil parameter 
 * if succeeded or with a request error if failed
 */
- (void)addOrChangeAddress:(OIAddress *)address usingBlock:(void (^)(NSError *error))block;

/**
 * Delete user address by its nickname. Call block with nil parameter 
 * if succeeded or with a request error if failed
 */
- (void)deleteAddressByNickname:(NSString *)nickname usingBlock:(void (^)(NSError *error))block;

/**
 * Load all user credit cards into the OIUser instance. Call block with nil parameter 
 * if succeeded or with a request error if failed
 */
- (void)loadCreditCardsUsingBlock:(void (^)(NSError *error))block;

/**
 * Load user credit card by its nickname. Call block with created OICreditCard instance if succeeded 
 * or with nil if failed
 */
- (void)loadCreditCardByNickname:(NSString *)nickname usingBlock:(void (^)(OICardInfo *cardInfo))block;

/**
 * Change user credit card (overwrite) or add if it doesn't exist. Call block with nil parameter 
 * if succeeded or with a request error if failed
 */
- (void)addOrChangeCreditCard:(OICardInfo *)creditCard usingBlock:(void (^)(NSError *error))block;

/**
 * Delete user credit card by its nickname. Call block with nil parameter 
 * if succeeded or with a request error if failed
 */
- (void)deleteCreditCardByNickname:(NSString *)nickname usingBlock:(void (^)(NSError *error))block;

/**
 * Load all user orders into the OIUser instance. Call block with nil parameter 
 * if succeeded or with a request error if failed
 */
- (void)loadOrderHistoryUsingBlock:(void (^)(NSError *error))block;

/**
 * Load user order by its ID. Call block with created OIOrder instance if succeeded 
 * or with nil if failed
 */
- (void)loadOrderByID:(NSString *)ID usingBlock:(void (^)(OIOrder *order))block;

/**
 * Update user password. Call block with nil parameter if succeeded or with a request error 
 * if failed
 */
- (void)updatePassword:(NSString *) password usingBlock:(void (^)(NSError *error))block;

#pragma mark -
#pragma mark Class methods

/**
 * Load account information by user email and password. Call block with created OIUser instance 
 * if succeeded or with nil if failed
 */
+ (void)accountInfo:(NSString *)email password:(NSString *)password usingBlockUser:(void (^)(OIUser *user))blockUser usingBlockError:(void (^)(NSError *error))blockError;

/**
 * Create new account for OIUser instance. Call block with nil parameter if succeeded or with a 
 * request error if failed
 */
+ (void)createNewAccount:(OIUser *)account password:(NSString *)password usingBlock:(void (^)(NSError *error))block;

/**
 * Create new OIUser instance by email, first name and last name.  
 */
+ (OIUser *)userWithEmail:(NSString *)email firstName:(NSString *)firstName lastName:(NSString *)lastName;

@end
