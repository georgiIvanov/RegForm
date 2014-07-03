//
//  GenderSegment.m
//  GiveAway
//
//  Created by uBo on 11/10/2013.
//
//

#import "BaseSegment.h"

@implementation BaseSegment

- (id)initWithItems:(NSArray *)items {
    self = [super initWithItems:items];
    if (self) {
        // Set divider images
        [self setDividerImage:[UIImage imageFromColor:[UIColor colorWithHexValue:CellSeparatorColor alpha:1.0]]
          forLeftSegmentState:UIControlStateNormal
            rightSegmentState:UIControlStateNormal
                   barMetrics:UIBarMetricsDefault];
        [self setDividerImage:[UIImage imageFromColor:[UIColor colorWithHexValue:@"#00d95b" alpha:1.0]]
          forLeftSegmentState:UIControlStateSelected
            rightSegmentState:UIControlStateNormal
                   barMetrics:UIBarMetricsDefault];
        [self setDividerImage:[UIImage imageFromColor:[UIColor colorWithHexValue:@"#00d95b" alpha:1.0]]
          forLeftSegmentState:UIControlStateNormal
            rightSegmentState:UIControlStateSelected
                   barMetrics:UIBarMetricsDefault];
        
        // Set background images
        UIImage *normalBackgroundImage = [UIImage imageFromColor:[UIColor colorWithHexValue:@"#ffffff" alpha:1.0]];
        [self setBackgroundImage:normalBackgroundImage
                        forState:UIControlStateNormal
                      barMetrics:UIBarMetricsDefault];
        UIImage *selectedBackgroundImage = [UIImage imageFromColor:[UIColor colorWithHexValue:@"#00d95b" alpha:1.0]];
        [self setBackgroundImage:selectedBackgroundImage
                        forState:UIControlStateSelected
                      barMetrics:UIBarMetricsDefault];
    }
    return self;
}

- (void)gender {
    NSDictionary *attributesNormal = @{UITextAttributeFont: [UIFont fontWithName:kStandartMessageFontName size:17.0],
                                       NSForegroundColorAttributeName: [UIColor colorWithHexValue:@"#000000" alpha:1.0]};
    
    NSDictionary *attributesSelected = @{UITextAttributeFont: [UIFont fontWithName:kStandartMessageFontName size:17.0],
                                         NSForegroundColorAttributeName: [UIColor colorWithHexValue:@"#ffffff" alpha:1.0]};
    
    [self setTitleTextAttributes:attributesNormal forState:UIControlStateNormal];
    [self setTitleTextAttributes:attributesSelected forState:UIControlStateSelected];
}

@end
