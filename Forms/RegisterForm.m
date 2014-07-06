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

@interface RegisterForm()

@property(nonatomic, weak) UIView* parent;

@end

@implementation RegisterForm

-(instancetype)initWithParentView:(UIView*)parent
{
    self = [super init];
    if(self)
    {
        self.parent = parent;
    }
    
    return self;
}

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
             FXFormFieldCell: [FXFormBirthDateCell class],
             @"parent": _parent
             };
}



- (NSDictionary *)genderField
{
    return @{
      FXFormFieldCell: [FXFormGenderCell class]
             };

}


@end
