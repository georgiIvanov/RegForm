//
//  InAppViewController.h
//  TestYL
//
//  Created by Georgi Ivanov on 7/8/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomFontLabel.h"
#import "UserAccount.h"

@interface InAppViewController : UIViewController

@property(nonatomic, strong) UserAccount* userAccount;

@property (weak, nonatomic) IBOutlet CustomFontLabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UITextView *userInfoTextView;


@end
