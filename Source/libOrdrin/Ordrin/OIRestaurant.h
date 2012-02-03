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
 */
#import <Foundation/Foundation.h>

@class OIDateTime;
@class OIAddress;
@class OIDelivery;

extern NSString *const OIRestaurantBaseURL;

@interface OIRestaurant : NSObject

@property (nonatomic, readonly, getter=isComplete) BOOL complete;
@property (nonatomic, readwrite, copy) NSString *id;
@property (nonatomic, readwrite, copy) NSString *name;
@property (nonatomic, readwrite, copy) NSString *phone;
@property (nonatomic, readwrite, retain) OIAddress *address;

- (void)deliveryCheckToAddress:(OIAddress *)address atTime:(OIDateTime *)dateTime usingBlock:(void (^)(OIDelivery *delivery))block;
- (void)downloadDetailUsingBlock:(void (^)(void))block;

#pragma mark -
#pragma mark Class methods

+ (void)restaurantsNearAddress:(OIAddress *)address availableAt:(OIDateTime *)dateTime usingBlock:(void (^)(NSArray *restaurants))block;

@end