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

@interface OIAddress : NSObject

@property (nonatomic, readwrite, copy) NSString *nickname;
@property (nonatomic, readwrite, copy) NSString *address1;
@property (nonatomic, readwrite, copy) NSString *address2;
@property (nonatomic, readwrite, copy) NSString *city;
@property (nonatomic, readwrite, copy) NSString *state;
@property (nonatomic, readwrite, retain) NSNumber *postalCode;
@property (nonatomic, readwrite, copy) NSString *phoneNumber;


#pragma mark -
#pragma mark Class methods

+ (OIAddress *)addressWithStreet:(NSString *)street city:(NSString *)city postalCode:(NSNumber *)postalCode;

@end