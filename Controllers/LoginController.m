//
//  LoginController.m
//  TestYL
//
//  Created by Georgi Ivanov on 7/3/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import "LoginController.h"
#import <Masonry.h>
#import <FXForms.h>
#import "LoginForm.h"
#import "BaseFormController.h"

@interface LoginController() <FXFormControllerDelegate>

@property(nonatomic, strong) UITableView* loginTable;
@property(nonatomic, strong) BaseFormController* formController;

@end

@implementation LoginController

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setupViews
{
    self.clipsToBounds = NO;
    self.backgroundColor = [UIColor redColor];
    self.loginTable = [[UITableView alloc] init];
    self.loginTable.scrollEnabled = NO;
    self.loginTable.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.formController = [[BaseFormController alloc] init];
    self.formController.tableView = self.loginTable;
    self.formController.delegate = self;
    self.formController.form = [[LoginForm alloc] init];
    
    [self addSubview:self.loginTable];
    
    [self.loginTable mas_makeConstraints:^(MASConstraintMaker* make){
        make.leading.equalTo(self.mas_leading);
        make.trailing.equalTo(self.mas_trailing);
        make.top.equalTo(self.mas_top);
        make.height.equalTo(@88);
    }];
    
    
    UIView* superview = self.superview;
    [self mas_makeConstraints:^(MASConstraintMaker *make){
        make.leading.equalTo(superview.mas_leading);
        make.trailing.equalTo(superview.mas_trailing);
        make.bottom.equalTo(superview.mas_bottom);
        make.height.equalTo(@200);
    }];
    
    
}

-(void)reloadViews
{
    [self.loginTable reloadData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
