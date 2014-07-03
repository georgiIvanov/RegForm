//
//  BaseUserAvatarView.h
//  GiveAway
//
//  Created by uBo on 07/03/2014.
//
//

#import <UIKit/UIKit.h>

@interface BaseUserAvatarView : UIView

@property (nonatomic, assign) UserGender gender;
@property (nonatomic, strong, readonly) UIImageView *avatarView;
@property (nonatomic, assign) BOOL online;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) NSUInteger borderPadding;
@property (nonatomic, assign) NSUInteger border;

- (void)resetForReuse;
- (void)avatarWithImage:(UIImage *)image;

@end
