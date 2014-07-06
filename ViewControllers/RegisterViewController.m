//
//  RegisterViewController.m
//  TestYL
//
//  Created by Georgi Ivanov on 7/6/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterController.h"
#import <POP.h>
#import "UIConstants.h"

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet RegisterController *registerController;

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
    [self.registerController setupObservers];
}

-(void)setupViews
{
    [self.registerController setupViews];
    UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"BackNavButton"] forState:UIControlStateNormal];
    [backBtn setFrame:CGRectMake(0, 0, 30, 30)];
    [backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    UIButton* nextBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [nextBtn setTitle:@"Next" forState:UIControlStateNormal];
    [nextBtn.titleLabel setFont:latoLightFont(23)];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn sizeToFit];
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithCustomView:nextBtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)nextButtonTap:(id)sender
{
    [self.view endEditing:YES];
    
    if([self.registerController validateFormFields])
    {
     
        [self.registerController.formTable setHidden:YES];
        [self.registerController.registerButtonContainer setHidden:NO];
        self.navigationItem.rightBarButtonItem = nil;
    }
    else
    {
        [self.registerController shakeForm];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)popViewController
{
    [self.registerController removeObservers];
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
