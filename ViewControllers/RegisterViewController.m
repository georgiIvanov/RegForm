//
//  RegisterViewController.m
//  TestYL
//
//  Created by Georgi Ivanov on 7/6/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"BackNavButton"] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(0, 0, 30, 30)];
    [btn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithCustomView:btn];
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


@end
