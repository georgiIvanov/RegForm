//
//  RegisterViewController.h
//  TestYL
//
//  Created by Georgi Ivanov on 7/6/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountServiceProtocol.h"

@interface RegisterViewController : UIViewController

@property(nonatomic, strong) id<AccountService> accountService;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


- (IBAction)registerTap:(id)sender;
- (IBAction)addPhotoTap:(id)sender;

@end
