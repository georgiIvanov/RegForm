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
#import <POP.h>
#import "UIConstants.h"
#import "LoginForm.h"
#import "BaseFormController.h"

@interface LoginController() <FXFormControllerDelegate>

@property(nonatomic, readonly) NSInteger formCellsCount;
@property(nonatomic, strong) UITableView* loginTable;
@property(nonatomic, strong) BaseFormController* formController;
@property(nonatomic, strong) LoginForm* loginForm;

// animation properties
@property(nonatomic, assign) CGFloat loginTableYDelta;

@end

@implementation LoginController

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        _formCellsCount = 2;
        _loginForm = [[LoginForm alloc] init];
    }
    return self;
}

-(void)setupViews
{
    NSNumber* tableHeight = [NSNumber numberWithInteger:self.formCellsCount * CellHeight];
    self.loginTable = [[UITableView alloc] init];
    self.loginTable.contentSize = CGSizeMake(0, tableHeight.intValue);
    self.loginTable.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    
    self.formController = [[BaseFormController alloc] init];
    self.formController.tableView = self.loginTable;
    self.formController.delegate = self;
    self.formController.form = self.loginForm;
    
    [self addSubview:self.loginTable];
    
    [self.loginTable mas_makeConstraints:^(MASConstraintMaker* make){
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
    
    
    id concreteValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect kbRect = [concreteValue CGRectValue];
    CGRect convertedKbRect = [self convertRect:kbRect fromView:self.superview];
    
    CGSize tableSize = self.loginTable.frame.size;

    self.loginTableYDelta = convertedKbRect.origin.y - tableSize.height;
    if(self.loginTableYDelta < 0 && ![self.loginTable pop_animationForKey:@"movingY"])
    {
        POPSpringAnimation* animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        animation.springBounciness = 20;
        animation.springSpeed = 10;
        
        __block MASConstraint* yConstraint;
        [self.loginTable mas_updateConstraints:^(MASConstraintMaker *make){
            yConstraint = make.top;
        }];
        [yConstraint uninstall];
        
        CGRect oldFrame = self.loginTable.frame;
        CGRect newFrame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y + self.loginTableYDelta, oldFrame.size.width, oldFrame.size.height);
        
        animation.toValue = [NSValue valueWithCGRect:newFrame];
        [self.loginTable pop_addAnimation:animation forKey:@"movingY"];
    }
}

-(void)keyboardWillHide:(NSNotification*)notification
{
    POPSpringAnimation* animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    animation.springBounciness = 15;
    animation.springSpeed = 14;
    
    CGRect oldFrame = self.loginTable.frame;
    CGRect newRect = CGRectMake(oldFrame.origin.x, oldFrame.origin.y - self.loginTableYDelta, oldFrame.size.width, oldFrame.size.height);
    animation.toValue = [NSValue valueWithCGRect:newRect];
    
    animation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        [self.loginTable mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.mas_top);
        }];
        self.loginTableYDelta = 0;
        [self.loginTable setNeedsLayout];
    };
    
    [self.loginTable pop_addAnimation:animation forKey:@"movingY"];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.loginTable scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]
                           atScrollPosition:UITableViewScrollPositionTop
                                   animated:NO];
}

-(void)reloadViews
{
    [self.loginTable reloadData];
}

- (IBAction)loginTapped:(id)sender
{
//    NSString* email = self.loginForm.email;
//    NSString* password = self.loginForm.password;
}

@end
