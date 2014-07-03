//
//  MKMapView+ZoomLevel.h
//  GiveAway
//
//  Created by uBo on 04/10/2012.
//
//

#import <MapKit/MapKit.h>

@interface MKMapView (ZoomLevel)
- (MKCoordinateSpan)coordinateSpanWithSize:(CGSize)size
                          centerCoordinate:(CLLocationCoordinate2D)centerCoordinate
                              andZoomLevel:(NSUInteger)zoomLevel;
- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;
- (NSUInteger) zoomLevel;
@end
