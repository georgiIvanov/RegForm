//
//  LoginController.m
//  TestYL
//
//  Created by Georgi Ivanov on 7/3/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import "LoginController.h"
#import "UIConstants.h"
#import "LoginForm.h"

@interface LoginController() <FXFormControllerDelegate>

@property(nonatomic, strong) LoginForm* loginForm;

@end

@implementation LoginController

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        self.formCellsCount = 2;
        _loginForm = [[LoginForm alloc] init];
    }
    return self;
}

-(void)setupViews
{
    [super setupViews];
    
    self.formController.form = self.loginForm;
    [self addSubview:self.formTable];
    
    NSNumber* tableHeight = [NSNumber numberWithInteger:self.formCellsCount * CellHeight];
    [self.formTable mas_makeConstraints:^(MASConstraintMaker* make){
        make.leading.equalTo(self.mas_leading);
        make.trailing.equalTo(self.mas_trailing);
        make.top.equalTo(self.mas_top);
        make.height.equalTo(tableHeight);
    }];
    
    
    UIView* superview = self.superview;
    [self mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(superview.mas_centerY);
    }];
    
    [self.forgotPwdButton.titleLabel setFont:latoLightFont(14)];
    [self.loginButton.titleLabel setFont:latoLightFont(18)];
    [self.signUpButton.titleLabel setFont:latoLightFont(14)];
    
}

-(void)keyboardWillShow:(NSNotification*)notification
{
    [super animateFormUp:notification bounciness:20];
}

-(void)keyboardWillHide:(NSNotification*)notification
{
    [super animateFormDown:notification bounciness:15];
}

-(void)reloadViews
{
    [self.formTable reloadData];
}

-(UserAccount*)userAccount
{
    UserAccount* user = [[UserAccount alloc] initWithEmail:self.loginForm.email password:self.loginForm.password];
    
    return user;
}

-(void)clearForm
{
    self.loginForm.email = @"";
    self.loginForm.password = @"";
    [self.formTable reloadData];
}

@end
