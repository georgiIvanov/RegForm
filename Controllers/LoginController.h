//
//  LoginController.h
//  TestYL
//
//  Created by Georgi Ivanov on 7/3/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

@interface LoginController : BaseController

@property (weak, nonatomic) IBOutlet UIButton *forgotPwdButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)loginTapped:(id)sender;

-(void)setupViews;
-(void)reloadViews;
@end
