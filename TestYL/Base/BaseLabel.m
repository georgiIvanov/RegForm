//
//  BaseLabel.m
//  GiveAway
//
//  Created by uBo on 10/10/2013.
//
//

#import "BaseLabel.h"

@implementation BaseLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.paddings = UIOffsetZero;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    if ( self.attributedText != nil ) {
        [self.attributedText drawWithRect:rect
                              options:NSStringDrawingUsesLineFragmentOrigin
                              context:nil];
    } else {
        [super drawRect:rect];
    }
}

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    
    if ( size.width > 0 ) {
        size.width += self.paddings.horizontal;
    }
    
    if ( size.height > 0 ) {
        size.height += self.paddings.vertical;
    }
    
    return size;
}

@end
