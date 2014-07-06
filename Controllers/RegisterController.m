//
//  RegisterController.m
//  TestYL
//
//  Created by Georgi Ivanov on 7/6/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import "RegisterController.h"
#import "RegisterForm.h"
#import "UIConstants.h"

@interface RegisterController()

@property(nonatomic, strong) RegisterForm* registerForm;

@end

@implementation RegisterController

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        self.formCellsCount = 5;
        _registerForm = [[RegisterForm alloc] init];
    }
    return self;
}

-(void)setupViews
{
    [super setupViews];
    
    self.formController.form = self.registerForm;
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
}

-(void)keyboardWillShow:(NSNotification*)notification
{
    [super animateFormUp:notification bounciness:15];
}

-(void)keyboardWillHide:(NSNotification*)notification
{
    [super animateFormDown:notification bounciness:10];
}

@end
