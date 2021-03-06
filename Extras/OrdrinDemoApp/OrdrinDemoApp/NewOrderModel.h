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

@class OIAddress;
@class OICardInfo;

@interface NewOrderModel : NSObject {
  
@private
  NSArray *__creditCards;
  NSArray *__restaurants;
  NSArray *__addresses;
  OIAddress *__address;
}

- (id)initWithAddress:(OIAddress *)address;

@property (nonatomic, readonly) NSArray *creditCards;
@property (nonatomic, readonly) NSArray *addresses;
@property (nonatomic, readonly) NSArray *restaurants;
@end
