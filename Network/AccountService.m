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
@property(nonatomic, strong) UserAccount* user;

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
    NSDictionary* userDict = [MTLJSONAdapter JSONDictionaryFromModel:user];
    
    [self.manager POST:[NSString stringWithFormat:@"%@%@", kDomainName, @"oauth2/signin"] parameters:userDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        UserAccount* loggedInUser = [MTLJSONAdapter modelOfClass:UserAccount.class fromJSONDictionary:responseObject error:&error];
        self.user = loggedInUser;
        onSuccess(loggedInUser);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        onError(user, operation.responseObject);
    }];
    
}

-(void)registerUser:(UserAccount*)user onSuccess:(void (^)(UserAccount* user))onSuccess onFailure:(void (^)(UserAccount* user, NSDictionary* error))onError
{
    
    NSDictionary* userDict = [MTLJSONAdapter JSONDictionaryFromModel:user];
    
    [self.manager POST:[NSString stringWithFormat:@"%@%@", kDomainName, @"oauth2/signup"] parameters:userDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        UserAccount* registeredUser = [MTLJSONAdapter modelOfClass:UserAccount.class fromJSONDictionary:responseObject error:&error];
        self.user = registeredUser;
        onSuccess(registeredUser);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        onError(user, operation.responseObject);
    }];
    
}

-(void)uploadAvatar:(UIImage *)image onSuccess:(void (^)(UserAccount *))onSuccess onFailure:(void (^)(NSDictionary *))onError
{
    NSData* imageData = UIImageJPEGRepresentation(image, 1);
    NSString* postUrl =[NSString stringWithFormat:@"%@%@%@", kDomainName, @"api/UserSettings/UploadAvatar?email=", _user.email];
    [self.manager POST:postUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"image" fileName:@"image" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        UserAccount* newAvatarUser = [MTLJSONAdapter modelOfClass:UserAccount.class fromJSONDictionary:responseObject error:&error];
        self.user = newAvatarUser;
        onSuccess(newAvatarUser);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        onError(operation.responseObject);
    }];
}

-(UserAccount*)userAccount
{
    return self.user;
}

@end
