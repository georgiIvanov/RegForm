//
//  BaseForm.m
//  GiveAway
//
//  Created by uBo on 15/04/2014.
//
//

#import "BaseForm.h"
#import "UIConstants.h"

@implementation BaseForm

- (UIFont *)defaultLabelFont {
    return [UIFont fontWithName:kLatoBold size:12.0f];
}

- (UIColor *)defaultLabelColor {
    return [UIColor colorWithHexValue:@"#818187" alpha:1.0];
}

- (UIFont *)defaultFormFont {
    return [UIFont fontWithName:kLatoBold size:17.0f];
}

- (UIColor *)defaultFormColor {
    return [UIColor colorWithHexValue:@"#000000" alpha:1.0];
}

@end
