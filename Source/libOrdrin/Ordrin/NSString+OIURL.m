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
#import "NSString+OIURL.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (OIURL)

- (NSString *)urlEncode {
  NSString *result = (NSString *) CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef) self,
                                                                          NULL,
                                                                          CFSTR( "!*'();:@&=+$,/?%#[] " ),
                                                                          kCFStringEncodingUTF8);
  return [result autorelease];
}

- (NSString *)sha256 {
  // Using UTF8Encoding
  const char *s = [self cStringUsingEncoding:NSUTF8StringEncoding];
  NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
  
  // This is the destination
  uint8_t digest[CC_SHA256_DIGEST_LENGTH] = {0};
  // This one function does an unkeyed SHA256 hash of your hash data
  CC_SHA256(keyData.bytes, keyData.length, digest);
  
  // Now convert to NSData structure to make it usable again
  NSData *out = [NSData dataWithBytes:digest
                               length:CC_SHA256_DIGEST_LENGTH];
  // description converts to hex but puts <> around it and spaces every 4 bytes
  NSString *hash = [out description];
  hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
  hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
  hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
  
  // hash is now a string with just the 40char hash value in it
  
  return hash;
  
}

@end
