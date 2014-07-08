//
//  UserAccount.m
//  TestYL
//
//  Created by Georgi Ivanov on 7/8/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import "UserAccount.h"

@implementation UserAccount

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

@end
