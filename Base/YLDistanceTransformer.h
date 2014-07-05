//
//  YLDistanceTransformer.h
//  GiveAway
//
//  Created by uBo on 19/03/2014.
//
//

#import <Foundation/Foundation.h>

@interface YLDistanceTransformer : NSObject

+ (CGFloat)sliderPositionFromDistance:(CGFloat)radiusInKm;
+ (NSString *)distanceTextFromMeters:(NSUInteger)meters;
+ (NSUInteger)distanceFromSliderPosition:(CGFloat)position;
+ (NSDictionary *)sliderValues;

@end
