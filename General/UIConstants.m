//
//  UIConstants.m
//  TestYL
//
//  Created by Georgi Ivanov on 7/5/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

CGFloat const CellHeight = 44;

NSString* const kLatoLight = @"Lato-Light";
NSString* const kLatoBold  = @"Lato-Bold";


NSString* const kLabelFontPath =  @"textLabel.font";
NSString* const kLabelTextPath =  @"textLabel.text";
NSString* const kLabelColorPath = @"textLabel.color";


UIFont* latoLightFont(CGFloat size)
{
    return [UIFont fontWithName:kLatoLight size:size];;
}

UIFont* latoBoldFont(CGFloat size)
{
    return [UIFont fontWithName:kLatoBold size:size];;
}
