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
 * Class contain informations about address (user/restaurant).
 */
#import <Foundation/Foundation.h>

@interface OIAddress : NSObject

/// The nickname of this address (i.e. Home, Work).
@property (nonatomic, readwrite, copy) NSString *nickname;
/// The street address.
@property (nonatomic, readwrite, copy) NSString *address1;
/// The 2nd line of the address (optional).
@property (nonatomic, readwrite, copy) NSString *address2;
/// The city.
@property (nonatomic, readwrite, copy) NSString *city;
/// The state.
@property (nonatomic, readwrite, copy) NSString *state;
/// The zip code.
@property (nonatomic, readwrite, retain) NSNumber *postalCode;
/// The phone number.
@property (nonatomic, readwrite, copy) NSString *phoneNumber;
/// User id is set only if address owner is user not restaurant.
@property (nonatomic, readwrite, copy) NSString *userId;

#pragma mark -
#pragma mark Instance methods

/**
 * This method return address as a string.
 *
 * @return Return string, which contain postal code, street and city name.
 */
- (NSString *)addressAsString;

/**
 * Update adrress, you must have set a delegate (if not your address will be changed 
 * only on the server side).
 *
 * @param address Changed address, which will replace previous address (OIAddress).
 *
 * @param block Block return nil if request finished successfully.
 */
- (void)updateAddressWithAddress:(OIAddress *)address usingBlock:(void (^)(NSError *error))block;

#pragma mark -
#pragma mark Class methods

/**
 * Add user address.
 *
 * @param address New address (OIAddress), which will be saved.
 *
 * @param block Block return nil if request finished successfully.
 */
+ (void)addAddress:(OIAddress *)address usingBlock:(void (^)(NSError *error))block;

/**
 * Load all user addresses into the OIUser instance.
 *
 * @param block Block return array of addresses.
 */
+ (void)loadAddressesUsingBlock:(void (^)(NSMutableArray *addresses))block;

/**
 * Load user address by its nickname. Call block with created OIAddress instance if 
 * succeeded.
 *
 * @param nickname The nickname of the searching address(i.e. Home, Work).
 * 
 * @param block Return address (OIAddress) specified by nickname.
 * 
 */
+ (void)loadAddressByNickname:(NSString *)nickname usingBlock:(void (^)(OIAddress *address))block;

/**
 * Delete user address by its nickname.
 *
 * @param nickname The nick name of the address, which will be deleted.
 *
 * @param block If request finished successfully return nil else some error (NSError).
 */
+ (void)deleteAddressByNickname:(NSString *)nickname usingBlock:(void (^)(NSError *error))block;

/**
 * Created simple address (OIAddress).
 *
 * @param street The street name.
 *
 * @param city The city.
 *
 * @param postalCode The zip code.
 *
 * @return Return instance of OIAddress.
 */
+ (OIAddress *)addressWithStreet:(NSString *)street city:(NSString *)city postalCode:(NSNumber *)postalCode;

@end
