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
 *      Daniel Krezelok (daniel.krezelok@tapmates.com)
 */

/**
 * Class contain informations about order item.
 */
#import <Foundation/Foundation.h>

@interface OIOrderItem : NSObject {
  
}

/// The id of the item.
@property (nonatomic, copy) NSString *ID;
/// The name of the item.
@property (nonatomic, copy) NSString *name;
/// The price of the item in cents.
@property (nonatomic, retain) NSNumber *price;
/// The quantity ordered.
@property (nonatomic, retain) NSNumber *quantity;
/** An array of hashes, each hash represents an option ordered with the main item. Each
 * option is of the same format as the item
 */
@property (nonatomic, retain) NSMutableArray *opts;

@end
