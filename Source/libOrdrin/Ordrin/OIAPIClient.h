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
 * Class allow to create requests for ordr.in api.
 * Class is singleton.
 */
#import <Foundation/Foundation.h>

extern NSString *const OIAPIClientVersion;

@class ASIHTTPRequest;
@class OIAPIGenericAuthenticator;

@interface OIAPIClient : NSObject

@property (nonatomic, readwrite, copy) NSString *apiKey;

/**
 * Method append request to the client (OIAPIClient).
 *
 * @param request Ordr.in request (ASIHTTPRequest).
 *
 * @param authorized Shows if request use authorization or not.
 */
- (void)appendRequest:(ASIHTTPRequest *)request authorized:(BOOL)authorized;

/**
 * Method append request to the client (OIAPIClient).
 *
 * @param request Ordr.in request (ASIHTTPRequest).
 *
 * @param authorized Shows if request use authorization or not.
 *
 * @param authenticator Generic authenticator (OIAPIGenericAuthenticator).
 */
- (void)appendRequest:(ASIHTTPRequest *)request authorized:(BOOL)authorized authenticator:(OIAPIGenericAuthenticator *)authenticator;

/**
 * Method append request to the client (OIAPIClient).
 *
 * @param request Ordr.in request (ASIHTTPRequest).
 *
 * @param authorized Shows if request use authorization or not.
 *
 * @param userAuthenticator User authenticator (OIAPIGenericAuthenticator).
 */
- (void)appendRequest:(ASIHTTPRequest *)request authorized:(BOOL)authorized userAuthenticator:(OIAPIGenericAuthenticator *)userAuthenticator;

+ (OIAPIClient *)sharedInstance;

@end