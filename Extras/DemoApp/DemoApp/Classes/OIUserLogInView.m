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

@implementation OIUserLogInView

#pragma mark -
#pragma mark Initialization

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
     
        UILabel *__labelUserEmail = [[UILabel alloc] initWithFrame:CGRectMake(35, 10, 80, 30)];
        __labelUserEmail.text = @"User Email:";
        __labelUserEmail.font = [UIFont systemFontOfSize:14.0];
    
        UITextField *__textFieldUserEmail = [[UITextField alloc] initWithFrame:CGRectMake(120, 10, 165, 30)];
        __textFieldUserEmail.borderStyle = UITextBorderStyleRoundedRect;
        __textFieldUserEmail.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
   
        UILabel *__labePassword = [[UILabel alloc] initWithFrame:CGRectMake(35, 50, 80, 30)];
        __labePassword.text = @"Password:";
        __labePassword.font = [UIFont systemFontOfSize:14.0];
        
        UITextField *__textFieldPassword = [[UITextField alloc] initWithFrame:CGRectMake(120, 50, 165, 30)];
        __textFieldPassword.borderStyle = UITextBorderStyleRoundedRect;
        __textFieldPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;     
        
        UIButton *__buttonLogIn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        __buttonLogIn.frame = CGRectMake(35, 90, 250, 30);
        [__buttonLogIn setTitle:@"Log In" forState:UIControlStateNormal];
        
        [__buttonLogIn addTarget:self action:@selector(buttonLogInPressed) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:__buttonLogIn]; 
        [self addSubview:__labePassword];
        [self addSubview:__labelUserEmail];
        [self addSubview:__textFieldUserEmail];
        [self addSubview:__textFieldPassword];
       
        [__labePassword release];
        [__labelUserEmail release];
        [__textFieldUserEmail release];  
        [__textFieldPassword release]; 
        
    }
    return self;
}

-(void)buttonLogInPressed {
    

}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
    [super dealloc];
}
@end
