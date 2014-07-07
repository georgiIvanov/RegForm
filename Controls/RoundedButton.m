//
//  RoundedButton.m
//  TestYL
//
//  Created by Georgi Ivanov on 7/5/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import "RoundedButton.h"
#import <POP.h>

@interface RoundedButton()

- (void)setup;
- (void)scaleToSmall;
- (void)scaleToFullSize;
- (void)scaleToDefault;

@property(nonatomic, assign) CGFloat touchDownXScale;
@property(nonatomic, assign) CGFloat touchDownYScale;
@property(nonatomic, assign) CGFloat touchUpXScale;
@property(nonatomic, assign) CGFloat touchUpYScale;

@end

@implementation RoundedButton

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _touchDownXScale = 0;
        _touchDownYScale = 0;
        _touchUpXScale   = 0;
        _touchUpYScale   = 0;
        [self setup];
    }
    return self;
}

-(void)setScalingTouchDownX:(CGFloat)xDown downY:(CGFloat)yDown touchUpX:(CGFloat)xUp upY:(CGFloat)yUp
{
    _touchDownXScale = xDown;
    _touchDownYScale = yDown;
    _touchUpXScale = xUp;
    _touchUpYScale = yUp;
}

- (void)setup
{
    [self addTarget:self action:@selector(scaleToSmall)
   forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    [self addTarget:self action:@selector(scaleToFullSize)
   forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(scaleToDefault)
   forControlEvents:UIControlEventTouchDragExit];
}

- (void)scaleToSmall
{
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(
                                                                 _touchDownXScale ? _touchDownXScale : 0.93f,
                                                                 _touchDownYScale ? _touchDownYScale : 0.95f
                                                                 )];
    scaleAnimation.duration = 0.1f;
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSmallAnimation"];
}

- (void)scaleToFullSize
{
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(3.f, 3.f)];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(
                                                                 _touchUpXScale ? _touchUpXScale : 1.f,
                                                                 _touchUpYScale ? _touchUpYScale : 1.f
                                                                 )];
    scaleAnimation.springBounciness = 8.0f;
    scaleAnimation.springSpeed = 15;
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSpringAnimation"];
}

- (void)scaleToDefault
{
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleDefaultAnimation"];
}

@end
