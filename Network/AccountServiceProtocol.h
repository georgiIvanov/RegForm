//
//  AccountServiceProtocol.h
//  TestYL
//
//  Created by Georgi Ivanov on 7/8/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserAccount.h"

@protocol AccountService <NSObject>

-(void)loginUser:(UserAccount*)user onSuccess:(void (^)(UserAccount* user))onSuccess onFailure:(void (^)(UserAccount* user, NSDictionary* error))onError;

-(void)registerUser:(UserAccount*)user onSuccess:(void (^)(UserAccount* user))onSuccess onFailure:(void (^)(UserAccount* user, NSDictionary* error))onError;

-(void)resetPassword:(NSString*)email onSuccess:(void (^)(NSDictionary* info))onSuccess onFailure:(void (^)(NSDictionary* error))onError;

@end