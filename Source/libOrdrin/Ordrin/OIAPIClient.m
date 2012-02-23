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
#import "OIAPIClient.h"
#import "OICore.h"
#import "ASINetworkQueue.h"
#import "ASIHTTPRequest.h"

NSString *const OIAPIClientVersion = @"1";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Interface

@interface OIAPIClient()

@property (nonatomic, readwrite, retain) ASINetworkQueue *requestQueue;

- (void)assignRequestQueue;
- (void)requestFinished:(ASIHTTPRequest *)request;
- (void)requestFailed:(ASIHTTPRequest *)request;
- (void)queueFinished:(ASINetworkQueue *)queue;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Implementation

@implementation OIAPIClient {
@private
  NSString                  *__apiKey;
  ASINetworkQueue           *__requestQueue;
  OIAPIGenericAuthenticator *__authenticator;
}

@synthesize apiKey        = __apiKey;
@synthesize requestQueue  = __requestQueue;

#pragma mark -
#pragma mark Lifecycle

- (id)init {
  if (( self = [super init] )) {
    [self assignRequestQueue];
  }
  return self;
}

- (void)assignRequestQueue {
  self.requestQueue = [ASINetworkQueue queue];
  [self.requestQueue setRequestDidFinishSelector:@selector(requestFinished:)];
  [self.requestQueue setRequestDidFailSelector:@selector(requestFailed:)];
  [self.requestQueue setQueueDidFinishSelector:@selector(queueFinished:)];
}

#pragma mark -
#pragma mark Properties

- (void)setApiKey:(NSString *)apiKey {
  if ( __apiKey != apiKey ) {
    OI_RELEASE_SAFELY( __apiKey );
    __apiKey = [apiKey copy];
    
    OI_RELEASE_SAFELY( __authenticator );
    __authenticator = [[OIAPIGenericAuthenticator alloc] initWithKey:__apiKey];
  }
}

#pragma mark -
#pragma mark Selectors

- (void)requestFinished:(ASIHTTPRequest *)request {
  
}

- (void)requestFailed:(ASIHTTPRequest *)request {
  
}

- (void)queueFinished:(ASINetworkQueue *)queue {
  
}

#pragma mark -
#pragma mark Public

- (void)appendRequest:(ASIHTTPRequest *)request authorized:(BOOL)authorized {
  [self appendRequest:request authorized:authorized authenticator:__authenticator];
}

- (void)appendRequest:(ASIHTTPRequest *)request authorized:(BOOL)authorized authenticator:(OIAPIGenericAuthenticator *)authenticator {
  if ( authorized ) {
    [request addRequestHeader:@"X-NAAMA-CLIENT-AUTHENTICATION" value:[authenticator authenticationValue]];
    [request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
  }
  
  [self.requestQueue addOperation:request];
  [self.requestQueue go];
}

- (void)appendRequest:(ASIHTTPRequest *)request authorized:(BOOL)authorized userAuthenticator:(OIAPIGenericAuthenticator *)userAuthenticator {
  if ( authorized ) {
    [request addRequestHeader:@"X-NAAMA-CLIENT-AUTHENTICATION" value:[__authenticator authenticationValue]];
    [request addRequestHeader:@"X-NAAMA-AUTHENTICATION" value:[userAuthenticator authenticationValue]];
    [request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
  }
  
  [self.requestQueue addOperation:request];
  [self.requestQueue go];
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __authenticator );
  OI_RELEASE_SAFELY( __apiKey );
  OI_RELEASE_SAFELY( __requestQueue );
  [super dealloc];
}

#pragma mark -
#pragma mark Singleton

+ (OIAPIClient *)sharedInstance {
	static dispatch_once_t pred;
	static OIAPIClient *instance = nil;
  
	dispatch_once(&pred, ^{ instance = [[self alloc] init]; });
	return instance;
}

@end