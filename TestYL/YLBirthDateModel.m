//
//  YLBirthDateModel.m
//  GiveAway
//
//  Created by uBo on 24/05/2014.
//
//

#import "YLBirthDateModel.h"

@implementation YLBirthDateModel

- (instancetype)initWithDate:(NSDate *)date public:(BOOL)publicDate {
    if ( self = [super init] ) {
        self.birthDate = date;
        self.birthDatePublic = publicDate;
    }
    
    return self;
}

@end
