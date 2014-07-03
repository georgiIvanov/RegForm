
@interface UIImage (VeplayCommon)

- (UIImage *)resizableImageWithSize:(CGSize)size;
+ (UIImage *)gradientImageWithColors:(NSArray *)gradientColors size:(CGSize)size;
- (CGSize)getSize;
+ (UIImage *)imageFromColor:(UIColor *)color;

@end
