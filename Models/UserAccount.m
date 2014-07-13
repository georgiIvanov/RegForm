//
//  UserAccount.m
//  TestYL
//
//  Created by Georgi Ivanov on 7/8/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import "UserAccount.h"
#import <Mantle.h>

@interface UserAccount()

@property (nonatomic, copy, readwrite) NSString *email;
@property (nonatomic, copy, readwrite) NSString *password;
@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, copy, readwrite) NSDate* birthDate;
@property (nonatomic, copy, readwrite) NSString* avatarUrl;
@property (nonatomic, assign, readwrite) Gender gender;
@property (nonatomic, assign, readwrite) BOOL birthDatePublic;


@end

@implementation UserAccount

-(instancetype)initWithEmail:(NSString*)email password:(NSString*)password
{
    self = [super init];
    if(self)
    {
        self.email = email;
        self.password = password;
    }
    return self;
}

-(instancetype)initWithEmail:(NSString*)email password:(NSString*)password name:(NSString*)name birthDate:(NSDate*)birthDate avatarUrl:(NSString*)avatarUrl gender:(Gender)gender birthdayPublic:(BOOL)birthdayPublic
{
    self = [self initWithEmail:email password:password];
    if(self)
    {
        self.name = name;
        self.birthDate = birthDate;
        self.avatarUrl = avatarUrl;
        self.gender = gender;
        self.birthDatePublic = birthdayPublic;
    }
    
    return self;
}

-(NSString*)userDescription
{
    NSString* publicBirthDate = self.birthDatePublic ? @"Yes" : @"No";
    NSString* gender;
    
    switch (self.gender) {
        case GenderMale:
            gender = @"Male";
            break;
        case GenderFemale:
            gender = @"Female";
            break;
        case GenderOther:
            gender = @"Private";
            break;
            
        default:
            break;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    NSString* result = [NSString stringWithFormat:@"Email: %@\nBirthDate: %@\nBirthDatePublic: %@\nGender: %@",
                        self.email, [dateFormatter stringFromDate:self.birthDate], publicBirthDate, gender];
    
    return result;
}

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"email": @"email",
             @"password": @"password",
             @"name": @"fullname",
             @"birthDate": @"birthday",
             @"birthDatePublic": @"birthDatePublic",
             @"avatarUrl": @"avatar",
             @"gender": @"gender"
             };
}

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    return dateFormatter;
}

+ (NSValueTransformer *)birthDateJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.dateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)birthDatePublicJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSNumber* datePublic) {
        return [datePublic integerValue] == 1 ? [NSNumber numberWithBool:YES] : [NSNumber numberWithBool:NO];
    } reverseBlock:^id(NSNumber* datePublic) {
        return [datePublic boolValue] == YES ? @"true" : @"false";
        
    }];
}

@end
