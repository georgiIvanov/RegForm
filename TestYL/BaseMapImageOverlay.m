//
//  BaseMapImageOverlay.m
//  GiveAway
//
//  Created by uBo on 15/04/2014.
//
//

#import "BaseMapImageOverlay.h"

@interface BaseMapImageOverlay ()

@property (nonatomic, assign) CLLocationCoordinate2D coord;

@end

@implementation BaseMapImageOverlay

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate {
    self = [super init];
    if (self != nil) {
        self.coord = coordinate;
    }
    return self;
}

- (MKMapRect)boundingMapRect
{
    
    MKMapPoint upperLeft = MKMapPointForCoordinate(self.coord);
    
    MKMapRect bounds = MKMapRectMake(upperLeft.x-10000, upperLeft.y-10000, 15000, 15000);
    return bounds;
}

@end
