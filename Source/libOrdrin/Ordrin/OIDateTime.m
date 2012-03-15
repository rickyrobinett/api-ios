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
#import "OIDateTime.h"
#import "OICore.h"

@implementation OIDateTime {
@private
  BOOL __asap;
  NSDate *__date;
}

#pragma mark -
#pragma mark Lifecycle

- (id)init {
  if (( self = [super init] )) {
    __asap = YES;
  }
  return self;
}

- (id)initWithDate:(NSDate *)date {
  if (( self = [super init] )) {
    __asap = NO;
    __date = [date retain];
  }
  return self;
}

#pragma mark -
#pragma mark Properties

- (NSString *)description {
  if ( __asap ) {
    return @"ASAP";
  }

//#warning It can take a longer time. It should be on another place.

  NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
  NSDateComponents *components = [calendar components:NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:__date];
  [calendar release];

  return [[NSString stringWithFormat:@"%d-%d+%d:%d", components.month, components.day, components.hour, components.minute] urlEncode];
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __date );
  [super dealloc];
}

#pragma mark -
#pragma mark Class

+ (OIDateTime *)dateTime:(NSDate *)date {
  return [[[OIDateTime alloc] initWithDate:date] autorelease];
}

+ (OIDateTime *)dateTimeASAP {
  return [[[OIDateTime alloc] init] autorelease];
}

@end