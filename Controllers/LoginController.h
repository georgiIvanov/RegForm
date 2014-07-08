//
//  LoginController.h
//  TestYL
//
//  Created by Georgi Ivanov on 7/3/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormController.h"
#import "UserAccount.h"

@interface LoginController : FormController

@property (weak, nonatomic) IBOutlet UIButton *forgotPwdButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

-(void)setupViews;
-(void)reloadViews;
-(UserAccount*)userAccount;

@end
