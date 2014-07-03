//
//  UIView+FrameAdditions.h
//  GiveAway
//
//  Created by uBo on 15/02/2013.
//
//

#import <UIKit/UIKit.h>



@interface UIView (FrameAdditions)

@property (nonatomic, assign) CGPoint $origin;
@property (nonatomic, assign) CGSize $size;
@property (nonatomic, assign) CGFloat $x, $y, $width, $height; // normal rect properties
@property (nonatomic, assign) CGFloat $left, $top, $right, $bottom; // these will stretch the rect

@end
