//
//  AccountService.m
//  TestYL
//
//  Created by Georgi Ivanov on 7/8/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import "AccountService.h"

static NSString* const kEmailKey = @"email";
static NSString* const kPasswordKey = @"password";
static NSString* const kNameKey = @"name";
static NSString* const kBirthDateKey = @"birthDate";
static NSString* const kBirthDatePublicKey = @"birthDatePublic";
static NSString* const kAvatarKey = @"avatar";
static NSString* const kGenderKey = @"gender";

@interface AccountService()

@property(nonatomic, strong) NSUserDefaults* userDefaults;

@end

@implementation AccountService

-(id)init
{
    self = [super init];
    if(self)
    {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

-(void)loginUser:(UserAccount*)user onSuccess:(void (^)(UserAccount* user))onSuccess onFailure:(void (^)(UserAccount* user, NSDictionary* error))onError
{
    NSDictionary* userDict = [self.userDefaults objectForKey:user.email];
    if(userDict == nil)
    {
        onError(user, @{@"error": @"No such user"});
        return;
    }
    
    UserAccount* userFound = [[UserAccount alloc] init];
    userFound.password = [userDict objectForKey:kPasswordKey];
    
    if(![userFound.password isEqualToString:user.password])
    {
        onError(user, @{@"error": @"Wrong password"});
        return;
    }
    
    userFound.email = [userDict objectForKey:kEmailKey];
    userFound.name = [userDict objectForKey:kNameKey];
    userFound.avatarUrl = [userDict objectForKey:kAvatarKey];
    userFound.birthDate = [userDict objectForKey:kBirthDateKey];
    userFound.birthDatePublic = [[userDict objectForKey:kBirthDatePublicKey] boolValue];
    userFound.gender = [[userDict objectForKey:kGenderKey] integerValue];
    
    onSuccess(userFound);
}

-(void)registerUser:(UserAccount*)user onSuccess:(void (^)(UserAccount* user))onSuccess onFailure:(void (^)(UserAccount* user, NSDictionary* error))onError
{
    NSDictionary* userDict = @{kEmailKey: user.email,
                               kPasswordKey: user.password,
                               kNameKey: user.name,
                               kBirthDateKey: user.birthDate,
                               kBirthDatePublicKey: @(user.birthDatePublic),
                               kAvatarKey: user.avatarUrl,
                               kGenderKey: @(user.gender)};
    
    [self.userDefaults setObject:userDict forKey:user.email];
    if(![self.userDefaults synchronize])
    {
        onError(user, @{@"error": @"Can't persist user"});
    }
    else
    {
        onSuccess(user);
    }
}

-(void)resetPassword:(NSString*)email onSuccess:(void (^)(NSDictionary* info))onSuccess onFailure:(void (^)(NSDictionary* error))onError
{
    
}

@end
