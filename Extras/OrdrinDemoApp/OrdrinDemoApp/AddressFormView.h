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
#import "OrdrinDemo.h"

@interface AddressFormView : UIView {
  
@private
  UITextField *__streetField;
  UITextField *__cityField;
  UITextField *__postalCodeField;
  
  UIButton *__findButton;
}

@property (nonatomic, readonly) UITextField *streetField;
@property (nonatomic, readonly) UITextField *cityField;
@property (nonatomic, readonly) UITextField *postalCodeField;

@property (nonatomic, readonly) UIButton *findButton;

@end
