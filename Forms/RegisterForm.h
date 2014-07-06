//
//  RegisterForm.h
//  TestYL
//
//  Created by Georgi Ivanov on 7/6/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import "BaseForm.h"
#import "BaseFormCells.h"
#import "LoginForm.h"

typedef NS_ENUM(NSInteger, Gender)
{
    GenderMale,
    GenderFemale,
    GenderOther,
    GenderInvalid
};


@interface RegisterForm : BaseForm

-(instancetype)initWithParentView:(UIView*)parent;

@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) FXFormBirthDateCell* birthDate;
@property (nonatomic, copy) FXFormGenderCell* gender;


@end
