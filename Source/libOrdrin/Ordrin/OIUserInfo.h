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

@class OIAPIUserAuthenticator;

@interface OIUserInfo : NSObject {
  
}

@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, assign) BOOL userLogged;

#pragma mark -
#pragma mark Instance methods

- (OIAPIUserAuthenticator *)createAuthenticatorWithUri:(NSString *)uri;
- (void)logout;

#pragma mark -
#pragma mark Singleton

+ (OIUserInfo *)sharedInstance;

@end
