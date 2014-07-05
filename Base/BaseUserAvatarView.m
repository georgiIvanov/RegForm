//
//  BaseUserAvatarView.m
//  GiveAway
//
//  Created by uBo on 07/03/2014.
//
//

#import <QuartzCore/QuartzCore.h>
#import "BaseUserAvatarView.h"

@interface BaseUserAvatarView ()

@property (nonatomic, strong) UIView *outterView;
@property (nonatomic, strong) UIImageView *borderView;

@end

@implementation BaseUserAvatarView

@synthesize gender = _gender;
@synthesize avatarView = _avatarView;
@synthesize online = _online;
@synthesize size = _size;
@synthesize borderPadding = _borderPadding;
@synthesize outterView = _outterView;
@synthesize borderView = _borderView;
@synthesize border = _border;

- (id)init
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.opaque = YES;
        
        _outterView = [[UIView alloc] init];
        self.outterView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.outterView.clipsToBounds = YES;
        
        _avatarView = [[UIImageView alloc] init];
        self.avatarView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.avatarView.clipsToBounds = YES;
        self.avatarView.contentMode = UIViewContentModeScaleAspectFill;
        
        [self.outterView addSubview:self.avatarView];
        [self addSubview:self.outterView];
        
        _borderView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar-border-offline.png"]];
        self.borderView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self addSubview:self.borderView];
        
    }
    return self;
}

- (void)dealloc {
    
}

- (void)setSize:(CGSize)size {
    if ( CGSizeEqualToSize(_size, size) ) {
        return;
    }
    
    _size = size;
    
    NSInteger offset = 1;
    
    if ( size.width > 40 ) {
        offset = 2;
    }
    
    self.$width = size.width + offset;
    self.$height = size.height + offset;
    
    self.outterView.frame = self.bounds;
    self.borderView.frame = CGRectMake(-offset, -offset, self.$width + offset, self.$height + offset);
    
    self.outterView.layer.cornerRadius = size.width/2;
    self.layer.cornerRadius = size.width/2;
}

- (void)setBorderPadding:(NSUInteger)borderPadding {
    if ( _borderPadding == borderPadding ) {
        return;
    }
    
    _borderPadding = borderPadding;
    
    self.outterView.$width = self.size.width - borderPadding;
    self.outterView.$height = self.size.height - borderPadding;
    self.outterView.layer.cornerRadius = self.outterView.$width / 2;
    
    self.outterView.center = self.center;
    self.borderView.center = self.center;
}

- (void)setBorder:(NSUInteger)border {
    _border = border;
    
    if ( border == 0 ) {
        self.borderView.hidden = YES;
    } else {
        self.borderView.hidden = NO;
    }
}

- (void)resetForReuse {
    self.avatarView.image = [UIImage imageNamed:@"avatar-male.png"];
    self.online = NO;
}

- (CGSize)intrinsicContentSize {
    return self.size;
}

- (void)setOnline:(BOOL)online {
    _online = online;
    
    if ( online ) {
        self.borderView.image = [UIImage imageNamed:@"avatar-border-online.png"];
    } else {
        self.borderView.image = [UIImage imageNamed:@"avatar-border-offline.png"];
    }
}

#pragma mark -

- (void)avatarWithImage:(UIImage *)image {
    self.avatarView.image = image;
}

@end
