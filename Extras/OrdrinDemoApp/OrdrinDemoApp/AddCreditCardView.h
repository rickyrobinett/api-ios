
#import <UIKit/UIKit.h>

@interface AddCreditCardView : UIView {

@private
  UITextField *__nickNameField;
  UITextField *__nameField;
  UITextField *__ccLastFiveField;
  UITextField *__expiryMonthField;
  UITextField *__expiryYearField;
  UITextField *__typeField;
  
  UITextField *__billAddr1Field;
  UITextField *__billAddr2Field;
  UITextField *__billCityField;
  UITextField *__billStateField;
  UITextField *__billZipField;
}

@property (nonatomic, readonly) UITextField *nickNameField;
@property (nonatomic, readonly) UITextField *nameField;
@property (nonatomic, readonly) UITextField *ccLastFiveField;
@property (nonatomic, readonly) UITextField *expiryMonthField;
@property (nonatomic, readonly) UITextField *expiryYearField;
@property (nonatomic, readonly) UITextField *typeField;
@property (nonatomic, readonly) UITextField *billAddr1Field;
@property (nonatomic, readonly) UITextField *billAddr2Field;
@property (nonatomic, readonly) UITextField *billCityField;
@property (nonatomic, readonly) UITextField *billStateField;
@property (nonatomic, readonly) UITextField *billZipField;

@end
