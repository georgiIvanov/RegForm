//
//  UserAccount.h
//  TestYL
//
//  Created by Georgi Ivanov on 7/8/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, Gender)
{
    GenderMale,
    GenderFemale,
    GenderOther,
    GenderInvalid
};

@interface UserAccount : NSObject

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate* birthDate;
@property (nonatomic, strong) NSURL* avatar;
@property (nonatomic, assign) Gender gender;


@end
