//
//  BaseUserAvatar.m
//  GiveAway
//
//  Created by uBo on 07/03/2014.
//
//

#import "BaseUserAvatar.h"

@interface BaseUserAvatar ()

@end

@implementation BaseUserAvatar

@synthesize view = _view;
@synthesize userId = _userId;
@synthesize cachePolicy = _cachePolicy;

- (instancetype)init {
    if ( self = [super init] ) {
        _view = [[BaseUserAvatarView alloc] init];
        
        [self.view.avatarView setImage:[UIImage imageNamed:@"avatar-male.png"]];
        
        self.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    }
    
    return self;
}

+ (BaseUserAvatar *)avatarWithSize:(CGSize)size border:(NSUInteger)border borderPadding:(NSUInteger)borderPadding {
    BaseUserAvatar *avatar = [[self alloc] init];
    
    avatar.view.size = size;
    avatar.view.borderPadding = borderPadding;
    avatar.view.border = border;
    
    return avatar;
}

- (NSURL *)urlFromString:(NSString *)path {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^https?" options:0 error:nil];
    
    // local file
    if ( [[regex matchesInString:path options:0 range:NSMakeRange(0, path.length)] count] == 0 ) {
        return [[NSURL alloc] initFileURLWithPath:path isDirectory:NO];
    } else {
        return [NSURL URLWithString:path];
    }
}

- (void)loadWithPath:(NSString *)path placeholder:(UIImage *)placeholder complete:(void(^)(UIImage *image))complete {
    if ( path == nil || [path isEqualToString:@""] ) {
        if ( placeholder ) {
            [self.view.avatarView setImage:placeholder];
        }
        return;
    }
    
    NSURLRequest *urlReq = [NSURLRequest requestWithURL:[self urlFromString:path]
                                            cachePolicy:self.cachePolicy timeoutInterval:30];
    
    BBlockWeakSelf weakSelf = self;
    
    [self.view.avatarView setImageWithURLRequest:urlReq
                      placeholderImage:placeholder
                               success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                   [weakSelf.view avatarWithImage:image];
                                   
                                   if ( complete ) {
                                       complete(image);
                                   }
                               }
                               failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                   
                               }];
}

- (void)addTarget:(id)target action:(SEL)action {
    
}

- (void)resetForReuse {
    self.userId = nil;
    
    [self.view resetForReuse];
}

- (void)addImage:(UIImage *)image {
    self.view.avatarView.image = image;
}

@end
