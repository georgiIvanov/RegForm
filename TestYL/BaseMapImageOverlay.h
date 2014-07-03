//
//  BaseMapImageOverlay.h
//  GiveAway
//
//  Created by uBo on 15/04/2014.
//
//

#import <Foundation/Foundation.h>

@interface BaseMapImageOverlay : NSObject <MKOverlay>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end
