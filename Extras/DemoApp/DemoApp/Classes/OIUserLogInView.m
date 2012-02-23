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

#import "OIUserLogInView.h"
#import "OIUserViewController.h"
#import "OIApplicationData.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Interface

@interface OIUserLogInView()< UITextFieldDelegate>
@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Implementation
@implementation OIUserLogInView {
@private
  UITextField *__textFieldUserEmail;
  UITextField *__textFieldPassword;
}

#pragma mark -
#pragma mark Initialization

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    
    UILabel *labelUserEmail = [[UILabel alloc] initWithFrame:CGRectMake(35, 10, 80, 30)];
    labelUserEmail.text = @"User Email:";
    labelUserEmail.font = [UIFont systemFontOfSize:14.0];
    
    __textFieldUserEmail = [[UITextField alloc] initWithFrame:CGRectMake(120, 10, 165, 30)];
    __textFieldUserEmail.borderStyle = UITextBorderStyleRoundedRect;
    __textFieldUserEmail.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    __textFieldUserEmail.delegate = self;
    
    UILabel *labePassword = [[UILabel alloc] initWithFrame:CGRectMake(35, 50, 80, 30)];
    labePassword.text = @"Password:";
    labePassword.font = [UIFont systemFontOfSize:14.0];
    
    __textFieldPassword = [[UITextField alloc] initWithFrame:CGRectMake(120, 50, 165, 30)];
    __textFieldPassword.borderStyle = UITextBorderStyleRoundedRect;
    __textFieldPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;    
    __textFieldPassword.delegate = self;
    
    UIButton *buttonLogIn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonLogIn.frame = CGRectMake(35, 90, 250, 30);
    [buttonLogIn setTitle:@"Log In" forState:UIControlStateNormal];
    
    [buttonLogIn addTarget:self action:@selector(buttonLogInPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:buttonLogIn]; 
    [self addSubview:labePassword];
    [self addSubview:labelUserEmail];
    [self addSubview:__textFieldUserEmail];
    [self addSubview:__textFieldPassword];
    
    [labePassword release];
    [labelUserEmail release];
    [__textFieldUserEmail release];  
    [__textFieldPassword release]; 
    
  }
  return self;
}

- (void)buttonLogInPressed {

  //  BOOL validInput = ([mail length] > 0 && [password length] > 0);
  //  
  //  if (!validInput)
  //  {
  //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Input" message:@"Please enter all items to proceed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];  
  //    [alert show];
  //    [alert release];
  //    return;
  //  }

  OIApplicationData *appDataManager = [OIApplicationData sharedInstance];

  [OIUser accountInfo:@"testuser@gmail.cz" password:@"tajneheslo" usingBlockUser:^(OIUser *user) {

    appDataManager.currentUser = user;
    appDataManager.userLogged  = YES;

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"User succesfully logged in." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];

    UIViewController *viewController = (UIViewController *) [[self superview] nextResponder];
    [(OIUserViewController *) viewController refresh];
    self.hidden = YES;

  }
  usingBlockError:^(NSError *error) {
    appDataManager.userLogged = NO;

    if ( error ) {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Can't log in with entered email and password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
      [alert show];
      [alert release];
    }
  }];
}

- (void)animateView:(UITextField *)textField up:(BOOL)up {
  const int   movementDistance = 165;
  const float movementDuration = 0.3f;

  int movement = (up ? -movementDistance : movementDistance);

  [UIView beginAnimations:@"anim" context:nil];
  [UIView setAnimationBeginsFromCurrentState:YES];
  [UIView setAnimationDuration:movementDuration];
  self.frame = CGRectOffset(self.frame, 0, movement);
  [UIView commitAnimations];

  UIViewController *viewController = (UIViewController *) [[self superview] nextResponder];
  [(OIUserViewController *) viewController hideButtons:up];
}

#pragma mark -
#pragma mark UITextFieldDelegate Protocol

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  [self animateView:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  [self animateView:textField up:NO];
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
  [super dealloc];
}

@end
