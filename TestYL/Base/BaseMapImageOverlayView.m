//
//  BaseMapImageOverlayView.m
//  GiveAway
//
//  Created by uBo on 15/04/2014.
//
//

#import "BaseMapImageOverlayView.h"

@implementation BaseMapImageOverlayView

- (id)initWithOverlay:(id <MKOverlay>)overlay {
    if ( self = [super initWithOverlay:overlay] ) {
        self.backgroundColor = [UIColor redColor];
    }
    
    return self;
}

- (void)drawMapRect:(MKMapRect)mapRect
          zoomScale:(MKZoomScale)zoomScale
          inContext:(CGContextRef)ctx
{
    CGImageRef imageReference = [UIImage imageNamed:@"overlay-grid.png"].CGImage;
    
    MKMapRect theMapRect    = [self.overlay boundingMapRect];
    CGRect theRect           = [self rectForMapRect:theMapRect];
    CGRect clipRect     = [self rectForMapRect:mapRect];
    
    CGContextAddRect(ctx, clipRect);
    CGContextClip(ctx);
    
    CGContextDrawImage(ctx, theRect, imageReference);
}

@end
