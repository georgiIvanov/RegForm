//
//  BaseFormTableView.m
//  GiveAway
//
//  Created by uBo on 16/05/2014.
//
//

#import "BaseFormTableView.h"

@interface BaseFormTableView ()

@property (nonatomic, weak) UIViewController *controller;

@end

@implementation BaseFormTableView

@synthesize controller = _controller;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style controller:(UIViewController *)controller {
    if ( self = [super initWithFrame:frame style:style] ) {
        _controller = controller;
    }
    
    return self;
}

- (BOOL)respondsToSelector:(SEL)selector
{
    return [super respondsToSelector:selector] || [self.controller respondsToSelector:selector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.controller;
}

@end
