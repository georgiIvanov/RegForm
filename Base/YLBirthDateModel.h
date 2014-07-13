//
//  YLBirthDateModel.h
//  GiveAway
//
//  Created by uBo on 24/05/2014.
//
//

#import <Foundation/Foundation.h>

@interface YLBirthDateModel : NSObject <NSCopying>

@property (nonatomic, strong) NSDate *birthDate;
@property (nonatomic, assign) BOOL birthDatePublic;

- (instancetype)initWithDate:(NSDate *)date public:(BOOL)publicDate;

@end
