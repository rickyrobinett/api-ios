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
 *      Daniel Krezelok (daniel.krezelok@tapmates.com)
 */

#import <Foundation/Foundation.h>
#import "OIRestaurantBase.h"

@class OIDateTime;
@class OIAddress;
@class OIDelivery;
@class OIOrder;
@class OIRDSInfo;

extern NSString *const OIRestaurantBaseURL;

@interface OIRestaurant : OIRestaurantBase

/// Restaurant address (OIAddress).
@property (nonatomic, readwrite, retain) OIAddress *address;
/// Restaurant state.
@property (nonatomic, readwrite, copy) NSString *state;
/// Restaurant meals.
@property (nonatomic, readwrite, retain) NSDictionary *meals;
/// Restaurant menu.
@property (nonatomic, readwrite, retain) NSDictionary *menu;
/// Restaurant info (OIRDSInfo).
@property (nonatomic, readwrite, retain) OIRDSInfo *rdsInfo;
/// Restaurant phone number.
@property (nonatomic, copy) NSString *phone;

#pragma mark -
#pragma mark Initializations

- (id)initWithRestaurantBase:(OIRestaurantBase *)restaurantBase;

#pragma mark -
#pragma mark Instance methods

/**
 * Check to see if a particular restaurant delivers to an address at the specified 
 * time.
 *
 * @param address (OIAddress)
 * Is a delivery address.
 * 
 * @param dateTime (OIDateTime)
 * Is delivery time.
 *
 * @param block
 * Block return delivery (OIDelivery) to an OIAddress at the specified 
 * OIDateTime.
 */
- (void)deliveryCheckToAddress:(OIAddress *)address atTime:(OIDateTime *)dateTime usingBlock:(void (^)(OIDelivery *delivery))block;

/**
 * Calculates all fees for a given subtotal and delivery address.
 * 
 * @param order (OIOrder)
 * Order, which is used for calculates all fees.
 * 
 * @param block
 * Block return delivery (OIDelivery)
 */
- (void)calculateFeesForSubtotal:(OIOrder *)order usingBlock:(void (^)(OIDelivery *delivery))block;

/**
 * Return array of menu items for given children IDs
 *
 * @param childrenIDs
 * All id's, which you need.
 *
 * @return
 * Return all menu items for each child id.
 */
- (NSArray *)menuItemsForChildrens:(NSArray *) childrenIDs;

#pragma mark -
#pragma mark Class methods

/**
 * Create restaurant (OIRestaurant) instance from base restaurant (OIRestaurantBase).
 *
 * @param restaurantBase (OIRestaurantBase)
 * Base informations, which are used for creat complete restaurant (OIRestaurant) 
 * instance.
 *
 * @param block
 * Block return complete restaurant (OIRestaurant) instance.
 */
+ (void)createRestaurantByRestaurantBase:(OIRestaurantBase *)restaurantBase usingBlock:(void (^)(OIRestaurant *restaurant))block;
@end