//
//  BaseUserAvatar.h
//  GiveAway
//
//  Created by uBo on 07/03/2014.
//
//

#import <Foundation/Foundation.h>
#import "BaseUserAvatarView.h"

@class BaseUserAvatarView;

@interface BaseUserAvatar : NSObject

@property (nonatomic, strong, readonly) BaseUserAvatarView *view;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, assign) NSURLRequestCachePolicy cachePolicy;

+ (BaseUserAvatar *)avatarWithSize:(CGSize)size border:(NSUInteger)border borderPadding:(NSUInteger)borderPadding;

- (void)loadWithPath:(NSString *)path placeholder:(UIImage *)placeholder complete:(void(^)(UIImage *image))complete;
- (void)addTarget:(id)target action:(SEL)action;
- (void)resetForReuse;
- (void)addImage:(UIImage *)image;

@end
