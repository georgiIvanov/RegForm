//
//  RecoverPasswordViewController.m
//  TestYL
//
//  Created by Georgi Ivanov on 7/5/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import "RecoverPasswordViewController.h"
#import "PasswordRecoveryController.h"
#import "UIConstants.h"

@interface RecoverPasswordViewController ()

@property (weak, nonatomic) IBOutlet PasswordRecoveryController *recoveryController;


@end

@implementation RecoverPasswordViewController

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
    [self setupViews];
    [self.recoveryController setupObservers];
}

-(void)setupViews
{
    [self.recoveryController setupViews];
    
    self.navigationItem.leftBarButtonItem = navigationBackButton(self, @selector(popViewController));
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)popViewController
{
    [self.recoveryController removeObservers];
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
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
