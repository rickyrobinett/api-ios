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

#import "OIAddress.h"
#import "OICore.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Implementation

@implementation OIAddress {
@private
  NSString *__nickname;
  NSString *__address1;
  NSString *__address2;
  NSString *__city;
  NSString *__state;
  NSNumber *__postalCode;
  NSString *__phoneNumber;
  NSString *__userId;
}

@synthesize nickname      = __nickname;
@synthesize address1      = __address1;
@synthesize address2      = __address2;
@synthesize city          = __city;
@synthesize state         = __state;
@synthesize postalCode    = __postalCode;
@synthesize phoneNumber   = __phoneNumber;
@synthesize userId        = __userId;

#pragma mark -
#pragma mark Properties

- (NSString *)description {
  return [NSString stringWithFormat:@"nickname: %@\naddress1: %@\naddress2: %@\ncity: %@\nstate: %@\nzip code: %d\nphone: %@\nuserId: %@", __nickname, [__address1 urlEncode], [__address2 urlEncode], [__city urlEncode], __state, __postalCode.intValue, __phoneNumber, __userId];
}

#pragma mark -
#pragma mark Instance methods

- (void)updateWithAddress:(OIAddress *)address {
  NSString *URL = [NSString stringWithFormat:@""];
  
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:URL]];
  [request setCompletionBlock:^void() {
    NSDictionary *json = [[request responseString] objectFromJSONString];
    NSNumber *error = [json objectForKey:@"_error"];
    if ( error.intValue == 0 ) {
      self.nickname = address.nickname;
      self.address1 = address.address1;
      self.address2 = address.address2;
      self.city = address.city;
      self.state = address.state;
      self.postalCode = address.postalCode;
      self.phoneNumber = address.phoneNumber;
      
    } else {
      NSString *msg = [json objectForKey:@"msg"];
      UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
      [alertView show];
      
      OI_RELEASE_SAFELY( alertView );
    }
  }];
  
  OIAPIClient *client = [OIAPIClient sharedInstance];
  [client appendRequest:request authorized:YES];
  
}

- (void)deleteAddress {

//  [[NSNotificationCenter defaultCenter] postNotificationName:@"" object:nil userInfo:nil];
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __userId );  
  OI_RELEASE_SAFELY( __nickname );
  OI_RELEASE_SAFELY( __address1 );
  OI_RELEASE_SAFELY( __address2 );
  OI_RELEASE_SAFELY( __city );
  OI_RELEASE_SAFELY( __state );
  OI_RELEASE_SAFELY( __postalCode );
  OI_RELEASE_SAFELY( __phoneNumber );
  
  [super dealloc];
}

#pragma mark -
#pragma mark Class methods

+ (OIAddress *)addressWithStreet:(NSString *)street city:(NSString *)city postalCode:(NSNumber *)postalCode {
  OIAddress *address = [[OIAddress alloc] init];
  address.address1 = street;
  address.city = city;
  address.postalCode = postalCode;
  
  return [address autorelease];
}

@end