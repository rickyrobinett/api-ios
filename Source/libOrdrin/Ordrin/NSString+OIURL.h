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
 * This addition brings methods like encode and encryption.
 */
#import <Foundation/Foundation.h>

@interface NSString (OIURL)

/**
 * This method encode string.
 *
 * @return Encoded string.
 */
- (NSString *)urlEncode;

/**
 * This method encrypted string. Encryption alghoritm is sha256.
 *
 * @return Encrypted string.
 */
- (NSString *)sha256;

@end
