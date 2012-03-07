
#import <UIKit/UIKit.h>

@interface UserMenuView : UIView {

@private
  UIButton *__accountInfoButton;
  UIButton *__addressButton;
  UIButton *__creditCardsButton;
  UIButton *__ordersHistoryButton;
  UIButton *__passwordButton;
  UIButton *__logoutButton;
}

@property (nonatomic, readonly) UIButton *accountInfoButton;
@property (nonatomic, readonly) UIButton *addressButton;
@property (nonatomic, readonly) UIButton *creditCardsButton;
@property (nonatomic, readonly) UIButton *ordersHistoryButton;
@property (nonatomic, readonly) UIButton *passwordButton;
@property (nonatomic, readonly) UIButton *logoutButton;

@end
