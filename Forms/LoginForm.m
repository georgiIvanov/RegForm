//
//  LoginForm.m
//  TestYL
//
//  Created by Georgi Ivanov on 7/3/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import "LoginForm.h"
#import "UIConstants.h"

@implementation LoginForm

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

@end
