//
//  InAppViewController.m
//  TestYL
//
//  Created by Georgi Ivanov on 7/8/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import "InAppViewController.h"
#import "BaseUserAvatar.h"
#import "UIConstants.h"

@interface InAppViewController ()

@property(nonatomic, strong) BaseUserAvatar* userAvatar;

@end

@implementation InAppViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = navigationBackButton(self, @selector(popViewController));
    
    self.welcomeLabel.text = [NSString stringWithFormat:@"Welcome, %@!", self.userAccount.name];
    
    self.userAvatar = [BaseUserAvatar avatarWithSize:self.avatarImageView.bounds.size border:0 borderPadding:0];
    [self.userAvatar loadWithPath:self.userAccount.avatarUrl placeholder:nil complete:^(UIImage *image) {
        self.avatarImageView.image = image;
        self.avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
    }];
    
        
    self.userInfoTextView.text = [self.userAccount userDescription];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)popViewController
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
