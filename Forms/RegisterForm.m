//
//  RegisterForm.m
//  TestYL
//
//  Created by Georgi Ivanov on 7/6/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import "RegisterForm.h"
#import "UIConstants.h"
#import "BaseSegment.h"

typedef NS_ENUM(NSInteger, Gender)
{
    GenderMale = 1,
    GenderFemale = 1 << 1,
    GenderOther = 0
};

@implementation RegisterForm

-(NSDictionary*) nameField
{
    return @{
             kLabelFontPath:  [super defaultLabelFont],
             kLabelTextPath:  @"NAME",
             kLabelColorPath: [super defaultLabelColor]
             };
}

-(NSDictionary*) emailField
{
    return @{
             kLabelFontPath:  [super defaultLabelFont],
             kLabelTextPath:  @"EMAIL",
             kLabelColorPath: [super defaultLabelColor]
             };
}

-(NSDictionary*) passwordField
{
    return @{
             kLabelFontPath:  [super defaultLabelFont],
             kLabelTextPath:  @"PASSWORD",
             kLabelColorPath: [super defaultLabelColor]
             };
}

-(NSDictionary*) birthDateField
{
    return @{
             FXFormFieldCell: [FXFormBirthDateCell class]
             };
}



- (NSDictionary *)genderField
{
    return @{
      FXFormFieldCell: [FXFormGenderCell class]
             };

}


@end
