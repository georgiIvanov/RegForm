//
//  PasswordRecoveryController.m
//  TestYL
//
//  Created by Georgi Ivanov on 7/5/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import "PasswordRecoveryController.h"
#import "UIConstants.h"
#import "BaseFormController.h"
#import "RecoveryForm.h"

@interface PasswordRecoveryController() <FXFormControllerDelegate>

@property(nonatomic, strong) RecoveryForm* recoveryForm;

@end

@implementation PasswordRecoveryController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.formCellsCount = 1;
        self.recoveryForm = [[RecoveryForm alloc] init];
    }
    return self;
}

-(void)setupViews
{
    [super setupViews];
    self.formController.form = self.recoveryForm;
    
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

@end
