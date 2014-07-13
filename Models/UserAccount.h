//
//  UserAccount.h
//  TestYL
//
//  Created by Georgi Ivanov on 7/8/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MTLModel.h>
#import <Mantle/MTLJSONAdapter.h>

typedef NS_ENUM(NSInteger, Gender)
{
    GenderInvalid,
    GenderMale,
    GenderFemale,
    GenderOther,
    
};

@interface UserAccount : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *email;
@property (nonatomic, copy, readonly) NSString *password;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSDate* birthDate;
@property (nonatomic, copy, readonly) NSString* avatarUrl;
@property (nonatomic, assign, readonly) Gender gender;
@property (nonatomic, assign, readonly) BOOL birthDatePublic;

-(NSString*)userDescription;
-(instancetype)initWithEmail:(NSString*)email password:(NSString*)password;
-(instancetype)initWithEmail:(NSString*)email password:(NSString*)password name:(NSString*)name birthDate:(NSDate*)birthDate avatarUrl:(NSString*)avatarUrl gender:(Gender)gender birthdayPublic:(BOOL)birthdayPublic;

@end
