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

-(void)clearForm
{
    
}

-(void)animateFormUp:(NSNotification*)notification bounciness:(CGFloat)bounciness
{
    id concreteValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect kbRect = [concreteValue CGRectValue];
    CGRect convertedKbRect = [self convertRect:kbRect fromView:self.superview];
    
    CGSize tableSize = self.formTable.frame.size;
    
    CGFloat deltaY = convertedKbRect.origin.y - tableSize.height;
    if(deltaY < 0 && ![self.formTable pop_animationForKey:@"movingY"])
    {
        self.formTableYDelta = deltaY;
        POPSpringAnimation* animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        animation.springBounciness = bounciness;
        animation.springSpeed = 10;
        
        CGRect oldFrame = self.formTable.frame;
        CGRect newFrame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y + self.formTableYDelta, oldFrame.size.width, oldFrame.size.height);
        
        animation.completionBlock = ^(POPAnimation *anim, BOOL finished){
            [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                CGFloat newY = self.frame.origin.y + self.formTable.frame.origin.y;
                make.top.equalTo(@(newY)).priorityLow();
                make.left.bottom.right.equalTo(self.superview);
            }];
            [self setNeedsLayout];
        };
        
        animation.toValue = [NSValue valueWithCGRect:newFrame];
        [self.formTable pop_addAnimation:animation forKey:@"movingY"];
    }
}

-(void)animateFormDown:(NSNotification*)notification bounciness:(CGFloat)bounciness
{
    if([self.formTable pop_animationForKey:@"movingY"])
    {
        return;
    }
    
    POPSpringAnimation* animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    animation.springBounciness = bounciness;
    animation.springSpeed = 14;
    
    CGRect oldFrame = self.formTable.frame;
    CGRect newRect = CGRectMake(oldFrame.origin.x, oldFrame.origin.y - self.formTableYDelta, oldFrame.size.width, oldFrame.size.height);
    animation.toValue = [NSValue valueWithCGRect:newRect];
    
    animation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            CGFloat newY = self.frame.origin.y + self.formTable.frame.origin.y;
            make.top.equalTo(@(newY));
        }];
        [self setNeedsLayout];
    };
    
    [self.formTable pop_addAnimation:animation forKey:@"movingY"];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.formTable scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:NO];
}

-(void)shakeFormBounciness:(CGFloat)bounciness speed:(CGFloat)speed
{
    POPSpringAnimation* shakeForm = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    shakeForm.springBounciness = bounciness;
    shakeForm.springSpeed = speed;
    shakeForm.fromValue = @(self.formTable.frame.origin.x);
    shakeForm.toValue = @([UIScreen mainScreen].bounds.size.width/2);
    [self.formTable.layer pop_addAnimation:shakeForm forKey:@"invalidEntry"];
}

-(void)hideFormDuration:(CFTimeInterval)duration
{
    POPBasicAnimation* scaleForm = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    scaleForm.toValue = [NSValue valueWithCGSize:CGSizeMake(0, 0)];
    scaleForm.duration = duration;
    scaleForm.completionBlock = ^(POPAnimation* animation, BOOL finished){
        [self.formTable setHidden:YES];
    };
    [self.formTable pop_removeAllAnimations];
    [self.formTable pop_addAnimation:scaleForm forKey:@"hideAnimation"];
}
@end
