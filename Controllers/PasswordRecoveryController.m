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

@property(nonatomic, strong) UITableView* recoveryTable;
@property(nonatomic, readonly) NSInteger formCellsCount;
@property(nonatomic, strong) BaseFormController* formController;
@property(nonatomic, strong) RecoveryForm* recoveryForm;

@end

@implementation PasswordRecoveryController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        _formCellsCount = 1;
        self.recoveryForm = [[RecoveryForm alloc] init];
    }
    return self;
}

-(void)setupViews
{
    NSNumber* tableHeight = [NSNumber numberWithInteger:self.formCellsCount * CellHeight];
    self.recoveryTable = [[UITableView alloc] init];
    self.recoveryTable.contentSize = CGSizeMake(0, tableHeight.intValue);
    self.recoveryTable.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    
    self.formController = [[BaseFormController alloc] init];
    self.formController.tableView = self.recoveryTable;
    self.formController.delegate = self;
    self.formController.form = self.recoveryForm;
    
    [self addSubview:self.recoveryTable];
    
    [self.recoveryTable mas_makeConstraints:^(MASConstraintMaker* make){
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
