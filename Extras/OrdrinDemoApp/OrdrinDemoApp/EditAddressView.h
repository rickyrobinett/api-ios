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

#import <UIKit/UIKit.h>

@class OIAddress;

@interface EditAddressView : UIView {

@private
  UITextField *__nickNameField;  
  UITextField *__addr1Field;
  UITextField *__addr2Field;
  UITextField *__cityField;
  UITextField *__stateField;
  UITextField *__zipField;
  UITextField *__phoneField;
  
  UILabel *__nickNameLabel;
  UILabel *__addr1Label;
  UILabel *__addr2Label;
  UILabel *__cityLabel;
  UILabel *__stateLabel;
  UILabel *__zipLabel;
  UILabel *__phoneLabel;  
}

- (id)initWithAddress:(OIAddress *)address;

@property (nonatomic, readonly) UITextField *nickNameField;
@property (nonatomic, readonly) UITextField *phoneField;
@property (nonatomic, readonly) UITextField *addr1Field;
@property (nonatomic, readonly) UITextField *addr2Field;
@property (nonatomic, readonly) UITextField *cityField;
@property (nonatomic, readonly) UITextField *stateField;
@property (nonatomic, readonly) UITextField *zipField;

@end
