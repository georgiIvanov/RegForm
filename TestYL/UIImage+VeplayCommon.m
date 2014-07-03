
#import "UIImage+VeplayCommon.h"


@implementation UIImage (VeplayCommon)

- (UIImage *)resizableImageWithSize:(CGSize)size
{
    if ( [UIImage respondsToSelector:@selector(resizableImageWithCapInsets:resizingMode:)]) {
        return [self resizableImageWithCapInsets:UIEdgeInsetsMake(size.height, size.width, size.height, size.width) resizingMode:UIImageResizingModeStretch];
    } else if( [UIImage respondsToSelector:@selector(resizableImageWithCapInsets:)] ) {
        return [self resizableImageWithCapInsets:UIEdgeInsetsMake(size.height, size.width, size.height, size.width)];
    } else {
        return [self stretchableImageWithLeftCapWidth:size.width topCapHeight:size.height];
    }
}

+ (UIImage *)gradientImageWithColors:(NSArray *)gradientColors size:(CGSize)size
{
    CGFloat width = size.width;         // max 1024 due to Core Graphics limitations
    CGFloat height = size.height;       // max 1024 due to Core Graphics limitations
    
    NSAssert(width <= 1024.0 && height <= 1024.0, @"Label dimensions should not exceed 1024 on any axis. Could work, but results might be unexpected");
    
    // create a new bitmap image context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    // get context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // push context to make it current (need to do this manually because we are not drawing in a UIView)
    UIGraphicsPushContext(context);
    
    //draw gradient
    CGGradientRef gradient;
    CGColorSpaceRef rgbColorspace;
    
    //set uniform distribution of color locations
    size_t num_locations = [gradientColors count];
    CGFloat locations[num_locations];
    for (int k=0; k<num_locations; k++) {
        locations[k] = k / (CGFloat)(num_locations - 1); //we need the locations to start at 0.0 and end at 1.0, equaly filling the domain
    }
    
    //create c array from color array
    CGFloat components[num_locations * 4];
    for (int i=0; i<num_locations; i++) {
        UIColor *color = [gradientColors objectAtIndex:i];
        components[4*i+0] = color.red;
        components[4*i+1] = color.green;
        components[4*i+2] = color.blue;
        components[4*i+3] = color.alpha;
    }
    
    rgbColorspace = CGColorSpaceCreateDeviceRGB();
    gradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
    CGPoint topCenter = CGPointMake(0, 0);
    CGPoint bottomCenter = CGPointMake(0, height);
    CGContextDrawLinearGradient(context, gradient, topCenter, bottomCenter, 0);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(rgbColorspace);
    
    // pop context
    UIGraphicsPopContext();
    
    // get a UIImage from the image context
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // clean up drawing environment
    UIGraphicsEndImageContext();
    
    return  gradientImage;
}

- (CGSize)getSize {
    CGImageRef imgRef = self.CGImage;
    
	CGSize srcSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    
    return srcSize;
}

+ (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

@end
