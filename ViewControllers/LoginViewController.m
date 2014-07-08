//
//  LoginViewController.m
//  TestYL
//
//  Created by Georgi Ivanov on 7/3/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginController.h"
#import "AccountService.h"
#import "RegisterViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet LoginController *loginController;
@property(nonatomic, strong) id<AccountService> accountService;
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
}

-(void)setupViews
{
    self.accountService = [[AccountService alloc] init];
    [self.loginController setupViews];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.loginController setupObservers];
    [self.loginController reloadViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"registerSegue"])
    {
        RegisterViewController* regVC = segue.destinationViewController;
        regVC.accountService = self.accountService;
        
    }
    [self.loginController removeObservers];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
