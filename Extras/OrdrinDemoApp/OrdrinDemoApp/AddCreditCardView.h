
#import <UIKit/UIKit.h>

@interface AddCreditCardView : UIView {

@private
  UITextField *__nickNameField;
  UITextField *__nameField;
  UITextField *__cvcField;
  UITextField *__expiryMonthField;
  UITextField *__expiryYearField;
  UITextField *__numberField;
  
  UITextField *__billAddr1Field;
  UITextField *__billAddr2Field;
  UITextField *__billCityField;
  UITextField *__billStateField;
  UITextField *__billZipField;
  
  UITextField *__phoneField;
  
  UILabel *__nickNameLabel;
  UILabel *__nameLabel;
  UILabel *__cvcLabel;
  UILabel *__expiryMonthLabel;
  UILabel *__expiryYearLabel;
  UILabel *__numberLabel;
  
  UILabel *__billAddr1Label;
  UILabel *__billAddr2Label;
  UILabel *__billCityLabel;
  UILabel *__billStateLabel;
  UILabel *__billZiplabel;

  UILabel *__phoneLabel;  
}

@property (nonatomic, readonly) UILabel *phoneLabel;
@property (nonatomic, readonly) UILabel *nickNameLabel;
@property (nonatomic, readonly) UILabel *nameLabel;
@property (nonatomic, readonly) UILabel *cvcLabel;
@property (nonatomic, readonly) UILabel *expiryMonthLabel;
@property (nonatomic, readonly) UILabel *expiryYearLabel;
@property (nonatomic, readonly) UILabel *numberLabel;
@property (nonatomic, readonly) UILabel *billAddr1Label;
@property (nonatomic, readonly) UILabel *billAddr2Label;
@property (nonatomic, readonly) UILabel *billCityLabel;
@property (nonatomic, readonly) UILabel *billStateLabel;
@property (nonatomic, readonly) UILabel *billZipLabel;

@property (nonatomic, readonly) UITextField *phoneField;
@property (nonatomic, readonly) UITextField *nickNameField;
@property (nonatomic, readonly) UITextField *nameField;
@property (nonatomic, readonly) UITextField *cvcField;
@property (nonatomic, readonly) UITextField *expiryMonthField;
@property (nonatomic, readonly) UITextField *expiryYearField;
@property (nonatomic, readonly) UITextField *numberField;
@property (nonatomic, readonly) UITextField *billAddr1Field;
@property (nonatomic, readonly) UITextField *billAddr2Field;
@property (nonatomic, readonly) UITextField *billCityField;
@property (nonatomic, readonly) UITextField *billStateField;
@property (nonatomic, readonly) UITextField *billZipField;

@end
