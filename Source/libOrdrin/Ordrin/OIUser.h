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

extern NSString const* OIUserBaseURL;

@interface OIUser : NSObject

@property (nonatomic, readwrite, copy) NSString *firstname;
@property (nonatomic, readwrite, copy) NSString *lastname;
@property (nonatomic, readwrite, copy) NSString *email;

#pragma mark -
#pragma mark Class methods

//+ (OIUser *)getAccountInfo:(NSString *)email password:(NSString *)password usingBlock:(void (^)(NSError *error))block;
+ (void)createNewAccount:(OIUser *)account password:(NSString *)password usingBlock:(void (^)(NSError *error))block;
+ (OIUser *)userWithEmail:(NSString *)email firstname:(NSString *)firstname lastname:(NSString *)lastname;

@end
