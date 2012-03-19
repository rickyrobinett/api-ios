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
 */

/**
 * Class represent generic authenticator.
 * Authenticator is used for requests, which requires authorization.
 */
#import <Foundation/Foundation.h>

@interface OIAPIGenericAuthenticator : NSObject

/**
 * Method create authenticator instance (OIAPIGenericAuthenticator).
 *
 * @param key Authenticator key.
 */
- (id)initWithKey:(NSString *)key;

/**
 * Method create authentication value(containing key and api client version) as NSString.
 *
 * @return key Authenticator key.
 */
- (NSString *)authenticationValue;

@end
