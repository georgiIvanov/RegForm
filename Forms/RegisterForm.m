//
//  RegisterForm.m
//  TestYL
//
//  Created by Georgi Ivanov on 7/6/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import "RegisterForm.h"
#import "UIConstants.h"

@implementation RegisterForm

-(NSDictionary*) nameField
{
    return @{
             kLabelFontPath:  [super defaultLabelFont],
             kLabelTextPath:  @"NAME",
             kLabelColorPath: [super defaultLabelColor]
             };
}

@end
