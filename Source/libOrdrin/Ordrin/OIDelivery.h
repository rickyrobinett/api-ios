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

@interface OIDelivery : NSObject

@property (nonatomic, readwrite, assign, getter=isAvailable) BOOL available;
@property (nonatomic, readwrite, retain) NSNumber *minimumAmount;
@property (nonatomic, readwrite, retain) NSDate *expectedTime;
@property (nonatomic, readwrite, copy) NSString *message;
@property (nonatomic, readwrite, retain) NSArray *meals;
@property (nonatomic, readwrite, copy) NSString *ID;
@property (nonatomic, readwrite, retain) NSNumber *fee;
@property (nonatomic, readwrite, retain) NSNumber *tax;

@end