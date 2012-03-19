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
 * Class contain informations about restaurant delivery.
 */
#import <Foundation/Foundation.h>

@interface OIDelivery : NSObject

/// Says if delivery is avalible or not.
@property (nonatomic, readwrite, assign, getter=isAvailable) BOOL available;
/// The minimum order for the requested delivery time and address.
@property (nonatomic, readwrite, retain) NSNumber *minimumAmount;
/// The expected delivery time in minutes for the requested delivery time and address.
@property (nonatomic, readwrite, retain) NSDate *expectedTime;
/// If it is not delivering, msg contains the reason why.
@property (nonatomic, readwrite, copy) NSString *message;
/// Meals that are being delivered at the requested time.
@property (nonatomic, readwrite, retain) NSArray *meals;
/// Delivery identifier.
@property (nonatomic, readwrite, copy) NSString *ID;
/// The fee to charge in dollars and cents.
@property (nonatomic, readwrite, retain) NSNumber *fee;
/// The tax to charge in dollars and cents.
@property (nonatomic, readwrite, retain) NSNumber *tax;

@end