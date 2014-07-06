//
//  FormController.m
//  TestYL
//
//  Created by Georgi Ivanov on 7/6/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import "FormController.h"
#import "UIConstants.h"
#import <POP.h>

@interface FormController() <FXFormControllerDelegate>

@end

@implementation FormController

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        
    }
    return self;
}
-(void)setupViews
{
    NSNumber* tableHeight = [NSNumber numberWithInteger:self.formCellsCount * CellHeight];
    self.formTable = [[UITableView alloc] init];
    self.formTable.contentSize = CGSizeMake(0, tableHeight.intValue);
    self.formTable.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    
    self.formController = [[BaseFormController alloc] init];
    self.formController.tableView = self.formTable;
    self.formController.delegate = self;
}

-(void)animateFormUp:(NSNotification*)notification
{
    id concreteValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect kbRect = [concreteValue CGRectValue];
    CGRect convertedKbRect = [self convertRect:kbRect fromView:self.superview];
    
    CGSize tableSize = self.formTable.frame.size;
    
    self.formTableYDelta = convertedKbRect.origin.y - tableSize.height;
    if(self.formTableYDelta < 0 && ![self.formTable pop_animationForKey:@"movingY"])
    {
        POPSpringAnimation* animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        animation.springBounciness = 20;
        animation.springSpeed = 10;
        
        __block MASConstraint* yConstraint;
        [self.formTable mas_updateConstraints:^(MASConstraintMaker *make){
            yConstraint = make.top;
        }];
        [yConstraint uninstall];
        
        CGRect oldFrame = self.formTable.frame;
        CGRect newFrame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y + self.formTableYDelta, oldFrame.size.width, oldFrame.size.height);
        
        animation.toValue = [NSValue valueWithCGRect:newFrame];
        [self.formTable pop_addAnimation:animation forKey:@"movingY"];
    }
}

-(void)animateFormDown:(NSNotification*)notification
{
    POPSpringAnimation* animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    animation.springBounciness = 15;
    animation.springSpeed = 14;
    
    CGRect oldFrame = self.formTable.frame;
    CGRect newRect = CGRectMake(oldFrame.origin.x, oldFrame.origin.y - self.formTableYDelta, oldFrame.size.width, oldFrame.size.height);
    animation.toValue = [NSValue valueWithCGRect:newRect];
    
    animation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        [self.formTable mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.mas_top);
        }];
        self.formTableYDelta = 0;
        [self.formTable setNeedsLayout];
    };
    
    [self.formTable pop_addAnimation:animation forKey:@"movingY"];
}
@end
