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
 *      Vitezslav Kot (vita@tapmates.com)
 */
#import <Foundation/Foundation.h>

extern NSString *const OIOrderBaseURL;

@class OIUser;
@class OIAddress;
@class OICardInfo;

@interface OIOrder : NSObject

@property (nonatomic, readwrite, copy) NSString *orderID;
@property (nonatomic, readwrite, copy) NSString *restaurantID;
@property (nonatomic, readwrite, copy) NSString *restaurantName;
@property (nonatomic, readwrite, retain) NSNumber *total;
@property (nonatomic, readwrite, retain) NSNumber *tip;
@property (nonatomic, readwrite, retain) NSDate *date;
@property (nonatomic, readwrite, retain) NSArray *items;

#pragma mark -
#pragma mark Instance methods

- (void)orderForUser:(OIUser *)user atAddress:(OIAddress*)address withCard:(OICardInfo *)card usingBlock:(void (^)(NSError *error))block;
- (NSNumber *) calculateSubtotal;

@end
