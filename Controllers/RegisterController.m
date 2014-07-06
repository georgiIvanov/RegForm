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
    }
    return self;
}

-(void)setupViews
{
    [super setupViews];
    
    self.registerForm = [[RegisterForm alloc] initWithParentView:self];
    [self.formController registerCellClass:[FXFormBirthDateCell class] forFieldType:@"FXFormBirthDateCell"];
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
        make.top.equalTo(superview.mas_centerY).priorityLow();
    }];
}

-(BOOL)validateFormFields
{
    YLBirthDateModel* date = (YLBirthDateModel*)self.registerForm.birthDate;
    if(date == nil)
    {
        return NO;
    }
    
    if(![self NSStringIsValidEmail:self.registerForm.email])
    {
        return NO;
    }
    
    if(self.registerForm.password == nil)
    {
        return NO;
    }
    
    if(self.registerForm.name == nil || [self.registerForm.name isEqualToString:@""])
    {
        return NO;
    }
    
    NSNumber* gender = (NSNumber*)self.registerForm.gender;
    if([gender unsignedIntegerValue] > GenderInvalid)
    {
        return NO;
    }
    
    return YES;
}

-(void)chooseAvatar
{
    
}

-(BOOL)NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
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
