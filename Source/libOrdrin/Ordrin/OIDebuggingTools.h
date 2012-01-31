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
#import <Foundation/Foundation.h>

#ifdef DEBUG

/**
 * Assertions that only fire when DEBUG is defined.
 *
 * An assertion is like a programmatic breakpoint. Use it for sanity checks to save headache while
 * writing your code.
 */
#import <TargetConditionals.h>

int OIIsInDebugger(void);
#if TARGET_IPHONE_SIMULATOR
// We leave the __asm__ in this macro so that when a break occurs, we don't have to step out of
// a "breakInDebugger" function.
#define OIDASSERT(xx) { if (!(xx)) { OIDLOG(@"NIDASSERT failed: %s", #xx); \
if (OIDebugAssertionsShouldBreak && OIIsInDebugger()) { __asm__("int $3\n" : : ); } } \
} ((void)0)
#else
#define OIDASSERT(xx) { if (!(xx)) { OIDLOG(@"OIDASSERT failed: %s", #xx); \
if (OIDebugAssertionsShouldBreak && OIIsInDebugger()) { raise(SIGTRAP); } } \
} ((void)0)
#endif // #if TARGET_IPHONE_SIMULATOR

#else
#define OIDASSERT(xx) ((void)0)
#endif // #ifdef DEBUG

#ifdef DEBUG
#define OIDLOG(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define OIDLOG(xx, ...)  ((void)0)
#endif // #ifdef DEBUG

#define OILOGLEVEL_INFO     5
#define OILOGLEVEL_WARNING  3
#define OILOGLEVEL_ERROR    1