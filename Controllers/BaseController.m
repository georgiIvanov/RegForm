//
//  BaseController.m
//  TestYL
//
//  Created by Georgi Ivanov on 7/5/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import "BaseController.h"

@implementation BaseController

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        
        
    }
    
    return self;
}

-(void)keyboardWillShow:(NSNotification*)notification
{
    
}

-(void)keyboardWillHide:(NSNotification*)notification
{
    
}
@end
