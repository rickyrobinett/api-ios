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

#import "OINewUserView.h"
#import "OIUser.h"
#import "OIUserViewController.h"
#import "OIApplicationData.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Interface

@interface OINewUserView()< UITextFieldDelegate>
@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Implementation

@implementation OINewUserView
{
@private
  UITextField *__textFieldUserEmail;
  UITextField *__textFieldFirstName;
  UITextField *__textFieldLastName;
  UITextField *__textFieldPassword;
}

#pragma mark -
#pragma mark Initialization

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    
    UILabel *__labelUserEmail = [[UILabel alloc] initWithFrame:CGRectMake(35, 10, 80, 30)];
    __labelUserEmail.text = @"User Email:";
    __labelUserEmail.font = [UIFont systemFontOfSize:14.0];
    
    __textFieldUserEmail = [[UITextField alloc] initWithFrame:CGRectMake(120, 10, 165, 30)];
    __textFieldUserEmail.borderStyle = UITextBorderStyleRoundedRect;
    __textFieldUserEmail.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    __textFieldUserEmail.delegate = self;
    
    UILabel *__labelFirstName = [[UILabel alloc] initWithFrame:CGRectMake(35, 50, 80, 30)];
    __labelFirstName.text = @"First Name:";
    __labelFirstName.font = [UIFont systemFontOfSize:14.0];
    
    __textFieldFirstName = [[UITextField alloc] initWithFrame:CGRectMake(120, 50, 165, 30)];
    __textFieldFirstName.borderStyle = UITextBorderStyleRoundedRect;
    __textFieldFirstName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    __textFieldFirstName.delegate = self;
    
    UILabel *__labelLastName = [[UILabel alloc] initWithFrame:CGRectMake(35, 90, 80, 30)];
    __labelLastName.text = @"Last Name:";
    __labelLastName.font = [UIFont systemFontOfSize:14.0];
    
    __textFieldLastName = [[UITextField alloc] initWithFrame:CGRectMake(120, 90, 165, 30)];
    __textFieldLastName.borderStyle = UITextBorderStyleRoundedRect;
    __textFieldLastName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;   
    __textFieldLastName.delegate = self;
    
    UILabel *__labePassword = [[UILabel alloc] initWithFrame:CGRectMake(35, 130, 80, 30)];
    __labePassword.text = @"Password:";
    __labePassword.font = [UIFont systemFontOfSize:14.0];
    
    __textFieldPassword = [[UITextField alloc] initWithFrame:CGRectMake(120, 130, 165, 30)];
    __textFieldPassword.borderStyle = UITextBorderStyleRoundedRect;
    __textFieldPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;  
    __textFieldPassword.delegate = self;
    
    UIButton *__buttonLogIn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    __buttonLogIn.frame = CGRectMake(35, 170, 250, 30);
    [__buttonLogIn setTitle:@"Create Account" forState:UIControlStateNormal];
    
    [__buttonLogIn addTarget:self action:@selector(buttonCreateAccountPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:__labelUserEmail];
    [self addSubview:__textFieldUserEmail];
    [self addSubview:__labelFirstName];
    [self addSubview:__textFieldFirstName];
    [self addSubview:__labelLastName];
    [self addSubview:__textFieldLastName];
    [self addSubview:__labePassword];
    [self addSubview:__textFieldPassword];
    [self addSubview:__buttonLogIn]; 
    
    [__labelUserEmail release];
    [__textFieldUserEmail release];
    [__labelFirstName release];
    [__textFieldFirstName release];
    [__labelLastName release];    
    [__textFieldLastName release];
    [__labePassword release];
    [__textFieldPassword release]; 
    
  }
  return self;
}

-(void)buttonCreateAccountPressed {
  
//  NSString *mail = [__textFieldUserEmail text];
//  NSString *firstName = [__textFieldFirstName text];
//  NSString *lastName = [__textFieldLastName text];
//  NSString *password = [__textFieldPassword text];
  
// BOOL validInput = [mail length]>0 && [firstName length]>0 && [lastName length]>0 && [password length];
//  
//  if (!validInput)
//  {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Input" message:@"Please enter all items to proceed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];  
//    [alert show];
//    [alert release];
//    return;
//  }
  
  OIUser *newUser = [OIUser userWithEmail:@"reichl@meap.cz" firstname:@"Petr" lastname:@"Reichl"];
  [OIUser createNewAccount:newUser password:@"tajne" usingBlock:^(NSError *error) {
    if ( error ) {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"User account could not be created!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]; 
      [alert show];
      [alert release];  
      OIDLOG(@"Error: %@", error);
    }
    else {
      OIApplicationData *appDataManager = [OIApplicationData sharedInstance];
      appDataManager.currentUser = newUser;
      appDataManager.userLogged = YES;
    }
  }];
}

- (void) animateView: (UITextField*) textField up: (BOOL) up
{
  const int movementDistance = 165; 
  const float movementDuration = 0.3f;
  
  int movement = (up ? -movementDistance : movementDistance);
  
  [UIView beginAnimations: @"anim" context: nil];
  [UIView setAnimationBeginsFromCurrentState: YES];
  [UIView setAnimationDuration: movementDuration];
  self.frame = CGRectOffset(self.frame, 0, movement);
  [UIView commitAnimations];
  
  UIViewController* viewController = (UIViewController*) [[self superview] nextResponder]; 
  [(OIUserViewController*)viewController hideButtons:up];
}

#pragma mark -
#pragma mark UITextFieldDelegate Protocol

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
  [self animateView: textField up: YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
  [self animateView: textField up: NO];
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  [super dealloc];
}
@end