//
//  AccountService.m
//  TestYL
//
//  Created by Georgi Ivanov on 7/8/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import "AccountService.h"
#import "AFNetworking.h"

static NSString* const kEmailKey = @"email";
static NSString* const kPasswordKey = @"password";
static NSString* const kNameKey = @"fullname";
static NSString* const kBirthDateKey = @"birthday";
static NSString* const kBirthDatePublicKey = @"birthDatePublic";
static NSString* const kAvatarKey = @"avatar";
static NSString* const kGenderKey = @"gender";

static NSString* const kDomainName = @"http://regformserver.apphb.com/";

@interface AccountService()

@property(nonatomic, strong) NSUserDefaults* userDefaults;
@property(nonatomic, strong) AFHTTPRequestOperationManager* manager;

@end

@implementation AccountService

-(id)init
{
    self = [super init];
    if(self)
    {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
        self.manager = [AFHTTPRequestOperationManager manager];
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
    
    if(![userFound.password isEqualToString:user.password])
    {
        onError(user, @{@"error": @"Wrong password"});
        return;
    }
    
    onSuccess(userFound);
}

-(void)registerUser:(UserAccount*)user onSuccess:(void (^)(UserAccount* user))onSuccess onFailure:(void (^)(UserAccount* user, NSDictionary* error))onError
{
    
    NSDictionary* userDict = [MTLJSONAdapter JSONDictionaryFromModel:user];
    
    [self.manager POST:[NSString stringWithFormat:@"%@%@", kDomainName, @"oauth2/signup"] parameters:userDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        UserAccount* registeredUser = [MTLJSONAdapter modelOfClass:UserAccount.class fromJSONDictionary:responseObject error:&error];
        NSLog(@"JSON: %@", responseObject);
        NSLog(@"%@", registeredUser);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        onError(user, @{@"error": error.localizedDescription});
    }];
    
}

-(void)resetPassword:(NSString*)email onSuccess:(void (^)(NSDictionary* info))onSuccess onFailure:(void (^)(NSDictionary* error))onError
{
    
}

@end
