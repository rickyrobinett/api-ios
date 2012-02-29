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

@interface OIMenuItem : NSObject
#warning Dopsat komenty
/// The menu item's id - this is what is used to create the tray.
@property (nonatomic, readwrite, copy) NSString *ID;
///
@property (nonatomic, readwrite, copy) NSString *orderID;
///
@property (nonatomic, readwrite, copy) NSNumber *availableForMealId;
///
@property (nonatomic, readonly, getter=isOrderable) BOOL orderable;
/// The name of the item.
@property (nonatomic, readwrite, copy) NSString *name;
/// An optional description of the item.
@property (nonatomic, readwrite, copy) NSString *description;
/// The optional price in dollars and cents.
@property (nonatomic, readwrite, copy) NSNumber *price;
///
@property (nonatomic, readonly, getter=isChildren) BOOL children;

@end
