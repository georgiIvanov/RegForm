//
//  RecoveryForm.m
//  TestYL
//
//  Created by Georgi Ivanov on 7/5/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import "RecoveryForm.h"
#import "UIConstants.h"

@implementation RecoveryForm

-(NSDictionary*) emailField
{
    return @{
             kLabelFontPath:  [super defaultLabelFont],
             kLabelTextPath:  @"EMAIL",
             kLabelColorPath: [super defaultLabelColor]
             };
}

@end
