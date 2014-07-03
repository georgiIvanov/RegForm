//
//  YLDistanceTransformer.m
//  GiveAway
//
//  Created by uBo on 19/03/2014.
//
//

#import "YLDistanceTransformer.h"


@implementation YLDistanceTransformer

+ (NSDictionary *)sliderValues {
    return @{@1.0: @50, @2.0: @100, @3.0: @200, @4.0: @500, @5.0: @1000, @6.0: @2000, @7.0: @3000,
             @8.0: @4000, @9.0: @5000, @10.0: @6000, @11.0: @7000, @12.0: @8000, @13.0: @9000, @14.0: @10000};
}

+ (CGFloat)sliderPositionFromDistance:(CGFloat)radiusInKm {
    
    NSUInteger radiusInMeters = radiusInKm*metersInKM;
    
    NSSet *keys = [[YLDistanceTransformer sliderValues] keysOfEntriesPassingTest:^BOOL(id key, id obj, BOOL *stop) {
        return radiusInMeters == [obj integerValue];
    }];
    
    id foundRadius = [keys anyObject];
    
    if ( foundRadius != nil ) {
        return [foundRadius floatValue];
    }
    
    return 1.0;
}

+ (NSUInteger)distanceFromSliderPosition:(CGFloat)position {
    position = (NSUInteger)position;
    
    NSUInteger mappedDistance = [[[YLDistanceTransformer sliderValues] objectForKey:[NSNumber numberWithFloat:position]] integerValue];
    
    return mappedDistance;
}

+ (NSString *)distanceTextFromMeters:(NSUInteger)meters {
    if ( meters < 1000 ) {
        return [NSString stringWithFormat:@"%d m", meters];
    }
    
    return [NSString stringWithFormat:@"%d km", (meters/metersInKM)];
}

@end
