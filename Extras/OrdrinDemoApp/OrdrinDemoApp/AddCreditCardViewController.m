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

#import "AddCreditCardViewController.h"
#import "AddCreditCardView.h"
#import "OICore.h"

@interface AddCreditCardViewController (Private)
- (void)saveButtonDidPress;
- (void)hideKeyboard;
@end

@implementation AddCreditCardViewController

#pragma mark -
#pragma mark Initializations

- (id)init {
  self = [super init];
  if ( self ) {
    self.title = @"Add new card";
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonDidPress)];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    
    OI_RELEASE_SAFELY( saveButtonItem );
  }
  
  return self;
}

#pragma mark -
#pragma mark Lifecycle

- (void)loadView {
  [super loadView];
  
  __addCreditCardView = [[AddCreditCardView alloc] init];
  
  __addCreditCardView.expiryYearField.delegate = self;
  __addCreditCardView.typeField.delegate = self;
  __addCreditCardView.billAddr1Field.delegate = self;
  __addCreditCardView.billAddr2Field.delegate = self;
  __addCreditCardView.billCityField.delegate = self;
  __addCreditCardView.billStateField.delegate = self;
  __addCreditCardView.billZipField.delegate = self;
  
  self.view  = __addCreditCardView;
}

- (void)viewDidUnload {
  [super viewDidUnload];
  
  [self releaseWithDealloc:NO];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  CGFloat originY = textField.frame.origin.y + textField.frame.size.height;
  if ( originY > 160 ) {
    CGRect frame = __addCreditCardView.frame;
    frame.origin.y = 160 - originY;

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:1.0];
    __addCreditCardView.frame = frame;
    [UIView commitAnimations];
  }
}

#pragma mark -
#pragma mark Events

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [self hideKeyboard];
  
  if ( __addCreditCardView.frame.origin.y != 0 ) {
    CGRect frame = __addCreditCardView.frame;
    frame.origin.y = 0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:1.0];
    __addCreditCardView.frame = frame;
    [UIView commitAnimations];
    
  }    
}

#pragma mark -
#pragma mark Memory management

- (void)releaseWithDealloc:(BOOL)dealloc {
  OI_RELEASE_SAFELY( __addCreditCardView );
  if ( dealloc ) {
  }  
}

- (void)dealloc {
  [self releaseWithDealloc:YES];
  [super dealloc];
}
@end

#pragma mark -
#pragma mark Private

@implementation AddCreditCardViewController (Private)

- (void)saveButtonDidPress {
  
}

- (void)hideKeyboard {
  [__addCreditCardView.nickNameField resignFirstResponder];
  [__addCreditCardView.nameField resignFirstResponder];
  [__addCreditCardView.ccLastFiveField resignFirstResponder];
  [__addCreditCardView.expiryMonthField resignFirstResponder];
  [__addCreditCardView.expiryYearField resignFirstResponder];
  [__addCreditCardView.typeField resignFirstResponder];
  [__addCreditCardView.billZipField resignFirstResponder];
  [__addCreditCardView.billStateField resignFirstResponder];
  [__addCreditCardView.billStateField resignFirstResponder];
  [__addCreditCardView.billCityField resignFirstResponder];
  [__addCreditCardView.billAddr2Field resignFirstResponder];
  [__addCreditCardView.billAddr1Field resignFirstResponder];
}

@end

