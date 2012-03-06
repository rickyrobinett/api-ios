
#import <UIKit/UIKit.h>

@interface LoginView : UIView {
  
@private
  UITextField *__emailField;
  UITextField *__passwordField;

  UIButton *__loginButton;
}

@property (nonatomic, readonly) UITextField *emailField;
@property (nonatomic, readonly) UITextField *passwordField;

@property (nonatomic, readonly) UIButton *loginButton;
@end
