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
 * Class represent date time.
 */
#import <Foundation/Foundation.h>

@interface OIDateTime : NSObject

/**
 * Initialization method, which create OIDateTime instance by date (NSDate).
 *
 * @param date A date time from which is create OIDateTime instance.
 *
 * @return Return instance of OIDateTime.
 */
- (id)initWithDate:(NSDate *)date;

/**
 * Method, which create OIDateTime instance by date (NSDate).
 *
 * @param date A date time from which is create OIDateTime instance.
 *
 * @return Return instance of OIDateTime.
 */
+ (OIDateTime *)dateTime:(NSDate *)date;

/**
 * Method create ASAP date time (instance of OIDateTime).
 *
 * @return Return instance of OIDateTime. 
 */
+ (OIDateTime *)dateTimeASAP;

@end