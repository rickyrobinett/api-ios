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
 *      Vitezslav Kot (vita@tapmates.com)
 */

#import "OIUserNewAddressViewController.h"
#import "OIApplicationData.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Interface

@interface OIUserNewAddressViewController()< UITextFieldDelegate>
@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Implementation
@implementation OIUserNewAddressViewController
{
@private  
  UITextField *__textFieldNickname;
  UITextField *__textFieldAddress1;
  UITextField *__textFieldAddress2;
  UITextField *__textFieldCity;
  UITextField *__textFieldState;
  UITextField *__textFieldZip;
  UITextField *__textFieldPhone;
  UIButton    *__buttonAdd;
}


#pragma mark - View lifecycle
- (void)loadView {
  [super loadView];

  self.title = NSLocalizedString( @"Add New Address", "" );
  
  self.view.backgroundColor = [UIColor whiteColor];
  
  UILabel *labelNickname = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 100, 30)];
  labelNickname.text = @"Nickname:";
  labelNickname.font = [UIFont systemFontOfSize:12.0];
  
  __textFieldNickname = [[UITextField alloc] initWithFrame:CGRectMake(120, 30, 190, 30)];
  __textFieldNickname.borderStyle = UITextBorderStyleRoundedRect;
  __textFieldNickname.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  __textFieldNickname.delegate = self;
  __textFieldNickname.text = @"Home";
  
  UILabel *labelAddress1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 100, 30)];
  labelAddress1.text = @"Address 1:";
  labelAddress1.font = [UIFont systemFontOfSize:12.0];
  
  __textFieldAddress1 = [[UITextField alloc] initWithFrame:CGRectMake(120, 70, 190, 30)];
  __textFieldAddress1.borderStyle = UITextBorderStyleRoundedRect;
  __textFieldAddress1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  __textFieldAddress1.delegate = self;
  __textFieldAddress1.text = @"820 University Dr";
  
  UILabel *labelAddress2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, 100, 30)];
  labelAddress2.text = @"Address 2 (opt):";
  labelAddress2.font = [UIFont systemFontOfSize:12.0];
  
  __textFieldAddress2 = [[UITextField alloc] initWithFrame:CGRectMake(120, 110, 190, 30)];
  __textFieldAddress2.borderStyle = UITextBorderStyleRoundedRect;
  __textFieldAddress2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  __textFieldAddress2.delegate = self; 
  __textFieldAddress2.text = @"Apartment 11";
  
  UILabel *labelCity = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, 100, 30)];
  labelCity.text = @"City:";
  labelCity.font = [UIFont systemFontOfSize:12.0];
  
  __textFieldCity = [[UITextField alloc] initWithFrame:CGRectMake(120, 150, 190, 30)];
  __textFieldCity.borderStyle = UITextBorderStyleRoundedRect;
  __textFieldCity.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  __textFieldCity.delegate = self; 
  __textFieldCity.text = @"College Station";
  
  UILabel *labelState = [[UILabel alloc] initWithFrame:CGRectMake(10, 190, 100, 30)];
  labelState.text = @"State:";
  labelState.font = [UIFont systemFontOfSize:12.0];
  
  __textFieldState = [[UITextField alloc] initWithFrame:CGRectMake(120, 190, 190, 30)];
  __textFieldState.borderStyle = UITextBorderStyleRoundedRect;
  __textFieldState.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  __textFieldState.delegate = self; 
  __textFieldState.text = @"Tx";
  
  UILabel *labelZip = [[UILabel alloc] initWithFrame:CGRectMake(10, 230, 100, 30)];
  labelZip.text = @"Zip Code:";
  labelZip.font = [UIFont systemFontOfSize:12.0];
  
  __textFieldZip = [[UITextField alloc] initWithFrame:CGRectMake(120, 230, 190, 30)];
  __textFieldZip.borderStyle = UITextBorderStyleRoundedRect;
  __textFieldZip.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  __textFieldZip.delegate = self; 
  __textFieldZip.text = @"77840";
  
  UILabel *labelPhone = [[UILabel alloc] initWithFrame:CGRectMake(10, 270, 100, 30)];
  labelPhone.text = @"Phone:";
  labelPhone.font = [UIFont systemFontOfSize:12.0];
  
  __textFieldPhone = [[UITextField alloc] initWithFrame:CGRectMake(120, 270, 190, 30)];
  __textFieldPhone.borderStyle = UITextBorderStyleRoundedRect;
  __textFieldPhone.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  __textFieldPhone.delegate = self; 
  __textFieldPhone.text = @"888-220-5126";
  
  __buttonAdd = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  __buttonAdd.frame = CGRectMake(35, 330, 250, 30);
  [__buttonAdd setTitle:@"Add Address" forState:UIControlStateNormal];
  [self.view addSubview:__buttonAdd]; 
  
  [__buttonAdd addTarget:self action:@selector(buttonAddPressed) forControlEvents:UIControlEventTouchUpInside]; 
  
  [self.view addSubview:__textFieldNickname]; 
  [self.view addSubview:__textFieldAddress1];
  [self.view addSubview:__textFieldAddress2];
  [self.view addSubview:__textFieldCity];
  [self.view addSubview:__textFieldState];
  [self.view addSubview:__textFieldZip];
  [self.view addSubview:__textFieldPhone];
  
  [self.view addSubview:labelNickname];
  [self.view addSubview:labelAddress1];
  [self.view addSubview:labelAddress2];
  [self.view addSubview:labelCity];
  [self.view addSubview:labelState];
  [self.view addSubview:labelZip];
  [self.view addSubview:labelPhone];
  
  [labelNickname release];
  [labelAddress1 release];
  [labelAddress2 release];
  [labelCity release];
  [labelState release];
  [labelZip release];
  [labelPhone release];
  
  [__textFieldNickname release];  
  [__textFieldAddress1 release]; 
  [__textFieldAddress2 release]; 
  [__textFieldCity release]; 
  [__textFieldState release]; 
  [__textFieldZip release];
  [__textFieldPhone release];
}

-(void)buttonAddPressed {
  
  BOOL validInput = ([[__textFieldNickname text] length] > 0 && [[__textFieldAddress1 text] length] > 0 && 
                     [[__textFieldCity text] length] > 0 && [[__textFieldState text] length] > 0 && 
                     [[__textFieldZip text] length] > 0 && [[__textFieldPhone text] length] > 0);
  
  if (!validInput)
  {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Input" message:@"Please enter all items to proceed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];  
    [alert show];
    [alert release];
    return;
  }
  
  NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
  [f setNumberStyle:NSNumberFormatterDecimalStyle];
  NSNumber * zipNumber = [f numberFromString:[__textFieldZip text]];
  [f release];
  
  OIAddress *address = [OIAddress addressWithStreet:[__textFieldAddress1 text] city:[__textFieldCity text] postalCode:zipNumber];
  address.nickname = [__textFieldNickname text];
  address.address2 = [__textFieldAddress2 text];
  address.state = [__textFieldState text];
  address.phoneNumber = [__textFieldPhone text];
  
  [OIAddress addAddress:address usingBlock:^void ( NSError *error ) {
    if(error) {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot add user address." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]; 
      [alert show];
      [alert release];      
    }    
    [[self navigationController] popViewControllerAnimated:YES];    
  }];
}

- (void)animateView:(UITextField *)textField up:(BOOL)up {
  const int   movementDistance = 165;
  const float movementDuration = 0.3f;

  int movement = (up ? -movementDistance : movementDistance);

  [UIView beginAnimations:@"anim" context:nil];
  [UIView setAnimationBeginsFromCurrentState:YES];
  [UIView setAnimationDuration:movementDuration];
  self.view.frame = CGRectOffset(self.view.frame, 0, movement);
  [UIView commitAnimations];
}

#pragma mark -
#pragma mark UITextFieldDelegate Protocol

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  CGRect rect = [textField frame];

  if ( rect.origin.y > 150 )
    [self animateView:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  CGRect rect = [textField frame];

  if ( rect.origin.y > 150 )
    [self animateView:textField up:NO];
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  OI_RELEASE_SAFELY( __textFieldNickname );
  OI_RELEASE_SAFELY( __textFieldAddress1 );
  OI_RELEASE_SAFELY( __textFieldAddress2 );
  OI_RELEASE_SAFELY( __textFieldCity );
  OI_RELEASE_SAFELY( __textFieldState );
  OI_RELEASE_SAFELY( __textFieldZip );
  OI_RELEASE_SAFELY( __textFieldPhone );
  [super dealloc];
}

@end
