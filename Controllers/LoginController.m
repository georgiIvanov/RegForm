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
#import "UIConstants.h"
#import "LoginForm.h"
#import "BaseFormController.h"

@interface LoginController() <FXFormControllerDelegate>

@property(nonatomic, readonly) NSInteger formCellsCount;
@property(nonatomic, strong) UITableView* loginTable;
@property(nonatomic, strong) BaseFormController* formController;


@end

@implementation LoginController

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        _formCellsCount = 2;
    }
    return self;
}

-(void)setupViews
{
    NSNumber* tableHeight = [NSNumber numberWithInteger:self.formCellsCount * CellHeight];
    self.loginTable = [[UITableView alloc] init];
    self.loginTable.scrollEnabled = NO;
    self.loginTable.contentSize = CGSizeMake(0, tableHeight.intValue);
    self.loginTable.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.loginTable.delegate = self;
    
    
    self.formController = [[BaseFormController alloc] init];
    self.formController.tableView = self.loginTable;
    self.formController.delegate = self;
    self.formController.form = [[LoginForm alloc] init];
    
    [self addSubview:self.loginTable];
    
    [self.loginTable mas_makeConstraints:^(MASConstraintMaker* make){
        make.leading.equalTo(self.mas_leading);
        make.trailing.equalTo(self.mas_trailing);
        make.top.equalTo(self.mas_top).priorityMedium();
        make.height.equalTo(tableHeight);
    }];
    
    
    UIView* superview = self.superview;
    [self mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(superview.mas_centerY);
    }];
    
    
}

-(void)keyboardWillShow:(NSNotification*)notification
{
    id concreteValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect kbRect = [concreteValue CGRectValue];
    CGRect convertedKbRect = [self convertRect:kbRect fromView:self.superview];
    
    CGSize tableSize = self.loginTable.frame.size;

    CGFloat delta = convertedKbRect.origin.y - tableSize.height;
    if(delta < 0)
    {
        [self.loginTable mas_updateConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(@( self.loginTable.frame.origin.y + delta));
        }];
    }
}

-(void)keyboardWillHide:(NSNotification*)notification
{
    [self.loginTable mas_updateConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.mas_top);
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (! self.loginTable.scrollEnabled)
        [self.loginTable scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
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
