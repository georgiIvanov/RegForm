//
//  MKCircleView+VeplayCommon.m
//  GiveAway
//
//  Created by uBo on 15/04/2014.
//
//

#import "MKCircleView+VeplayCommon.h"

@implementation MKCircleView (VeplayCommon)

+ (MKCircleView *)redCircleWithOverlay:(id)overlay {
    MKCircleView* circleView = [[MKCircleView alloc] initWithOverlay:overlay];
    
    circleView.strokeColor = [UIColor colorWithHexValue:@"#fb0007" alpha:0.6];
    circleView.lineWidth = 1.0;
    circleView.fillColor = [UIColor colorWithHexValue:@"#e46c7f" alpha:0.6];
    
    return circleView;
}

@end
