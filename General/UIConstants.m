//
//  UIConstants.m
//  TestYL
//
//  Created by Georgi Ivanov on 7/5/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

CGFloat const CellHeight = 44;

NSString* const kLatoLight =   @"Lato-Light";
NSString* const kLatoBold  =   @"Lato-Bold";
NSString* const kLatoRegular = @"Lato-Regular";


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

UIFont* latoRegularFont(CGFloat size)
{
    return [UIFont fontWithName:kLatoRegular size:size];;
}

UIColor* formTextColor()
{
    return [UIColor colorWithHexValue:@"#818187" alpha:1.0];
}

UIBarButtonItem* navigationBackButton(id target, SEL onTouch)
{
    UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"BackNavButton"] forState:UIControlStateNormal];
    [backBtn setFrame:CGRectMake(0, 0, 30, 30)];
    [backBtn addTarget:target action:onTouch forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}