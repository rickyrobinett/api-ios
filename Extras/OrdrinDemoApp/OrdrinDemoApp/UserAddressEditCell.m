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

#import "UserAddressEditCell.h"

#define BUTTON_PADDING          20
#define BUTTON_WIDTH            70
#define BUTTON_HEIGHT           30

#define EDIT_BUTTON_FRAME       CGRectMake (BUTTON_PADDING, 5, BUTTON_WIDTH, BUTTON_HEIGHT)
#define DELETE_BUTTON_FRAME     CGRectMake (230, 5, BUTTON_WIDTH, BUTTON_HEIGHT)

@interface UserAddressEditCell (Private)
- (void)editButtonDidPress;
- (void)deleteButtonDidPress;
@end

@implementation UserAddressEditCell

@synthesize section = __section;

#pragma mark -
#pragma mark Initializations

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];  
  if (self) {
    __deleteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [__deleteButton setTitle:@"DELETE" forState:UIControlStateNormal];
    
    __editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [__editButton setTitle:@"EDIT" forState:UIControlStateNormal];
    
    [self addSubview:__deleteButton];
    [self addSubview:__editButton];
  }  
  
  return self;
}

#pragma mark -
#pragma mark Lifecycles

- (void)layoutSubviews {
  [super layoutSubviews];
  
  if ( !CGRectEqualToRect(__deleteButton.frame, DELETE_BUTTON_FRAME) ) {
    __deleteButton.frame = DELETE_BUTTON_FRAME;
  }
  
  if ( !CGRectEqualToRect(__editButton.frame, EDIT_BUTTON_FRAME) ) {
    __editButton.frame = EDIT_BUTTON_FRAME;
  }
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  __editButton = nil;
  __deleteButton = nil;
  
  [super dealloc];
}

@end

#pragma mark -
#pragma mark Private

@implementation UserAddressEditCell (Private)

- (void)editButtonDidPress {
  NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:__section] forKey:@"section"];
  [[NSNotificationCenter defaultCenter] postNotificationName:kEditButtonDidPressNotification object:nil userInfo:userInfo];
}

- (void)deleteButtonDidPress {
  NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:__section] forKey:@"section"];
  [[NSNotificationCenter defaultCenter] postNotificationName:kDeleteButtonDidPressNotification object:nil userInfo:userInfo];  
}

@end
