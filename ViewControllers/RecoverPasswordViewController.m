//
//  RecoverPasswordViewController.m
//  TestYL
//
//  Created by Georgi Ivanov on 7/5/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import "RecoverPasswordViewController.h"
#import "PasswordRecoveryController.h"

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
}

-(void)setupViews
{
    [self.recoveryController setupViews];
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"BackNavButton"] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(0, 0, 30, 30)];
    [btn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithCustomView:btn];
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
