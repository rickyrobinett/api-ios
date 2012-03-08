
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
  
  UILabel *__nickNameLabel;
  UILabel *__nameLabel;
  UILabel *__ccLastFiveLabel;
  UILabel *__expiryMonthLabel;
  UILabel *__expiryYearLabel;
  UILabel *__typeLabel;
  
  UILabel *__billAddr1Label;
  UILabel *__billAddr2Label;
  UILabel *__billCityLabel;
  UILabel *__billStateLabel;
  UILabel *__billZiplabel;
  
}

@property (nonatomic, readonly) UILabel *nickNameLabel;
@property (nonatomic, readonly) UILabel *nameLabel;
@property (nonatomic, readonly) UILabel *ccLastFiveLabel;
@property (nonatomic, readonly) UILabel *expiryMonthLabel;
@property (nonatomic, readonly) UILabel *expiryYearLabel;
@property (nonatomic, readonly) UILabel *typeLabel;
@property (nonatomic, readonly) UILabel *billAddr1Label;
@property (nonatomic, readonly) UILabel *billAddr2Label;
@property (nonatomic, readonly) UILabel *billCityLabel;
@property (nonatomic, readonly) UILabel *billStateLabel;
@property (nonatomic, readonly) UILabel *billZipLabel;

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
