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

@interface CreateAccountView : UIView {

@private
  UILabel *__emailLabel;
  UILabel *__firstNameLabel;
  UILabel *__lastNameLabel;
  UILabel *__passwordLabel;
  
  UITextField *__emailField;
  UITextField *__firstNameField;
  UITextField *__lastNameField;
  UITextField *__passwordField;
  
  UIButton *__createAccountButton;
}

@property (nonatomic, readonly) UIButton *createAccountButton;
@property (nonatomic, readonly) UITextField *emailField;
@property (nonatomic, readonly) UITextField *firstNameField;
@property (nonatomic, readonly) UITextField *lastNameField;
@property (nonatomic, readonly) UITextField *passwordField;

@end
