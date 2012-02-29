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

@class OIDateTime;
@class OIAddress;

@interface OIRestaurantBase : NSObject

/// Unigue restaurant ID
@property (nonatomic, copy) NSString *ID;
/// Restaurant name
@property (nonatomic, copy) NSString *name;

#pragma mark -
#pragma mark Initializations

- (id)initWithRestaurantBase:(OIRestaurantBase *)restaurantBase;

#pragma mark -
#pragma mark Class methods

/**
 * Get list of restaurants that deliver to a particular address
 */
+ (void)restaurantsNearAddress:(OIAddress *)address availableAt:(OIDateTime *)dateTime usingBlock:(void (^)(NSArray *restaurants))block;
@end