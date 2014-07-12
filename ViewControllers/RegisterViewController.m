//
//  RegisterViewController.m
//  TestYL
//
//  Created by Georgi Ivanov on 7/6/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterController.h"
#import "InAppViewController.h"
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
    self.navigationItem.leftBarButtonItem = navigationBackButton(self, @selector(popViewController));
    
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
    if([self.registerController.formTable pop_animationKeys].count > 0)
    {
        return;
    }
    [self.view endEditing:YES];
    
    if([self.registerController validateFormFields])
    {
        [self.accountService registerUser:[self.registerController userAccount] onSuccess:^(UserAccount *user) {
            
            
            
        } onFailure:^(UserAccount *user, NSDictionary *error) {
            NSLog(@"Fail %@", error);
        }];
        
        
        [self.registerController hideFormDuration:0.4];
        [self showSecondPartOfRegistration];
        self.navigationItem.rightBarButtonItem = nil;
    }
    else
    {
        [self.registerController shakeFormBounciness:15 speed:30];
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"inAppSegue"])
    {
        InAppViewController* inAppVC = segue.destinationViewController;
        inAppVC.userAccount = sender;
    }
    
    [self.registerController removeObservers];
}

-(void)showSecondPartOfRegistration
{
    [self.registerController.formTable removeFromSuperview];
    CGRect originalRect = self.registerController.registerButtonContainer.frame;
    
    self.registerController.registerButtonContainer.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
    [self.registerController.registerButtonContainer setHidden:NO];
    POPBasicAnimation* scale = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    scale.duration = 0.9;
    scale.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    
    POPBasicAnimation* moveYAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    moveYAnimation.duration = 1.2;
    moveYAnimation.toValue = @(originalRect.size.height/2 + originalRect.origin.y);
    
    [self.registerController.registerButtonContainer pop_addAnimation:moveYAnimation forKey:@"moveY"];
    [self.registerController.registerButtonContainer pop_addAnimation:scale forKey:@"showViewAnimation"];
}

- (IBAction)registerTap:(id)sender {
    
    
    [self performSegueWithIdentifier:@"inAppSegue" sender:[self.registerController userAccount]];
}
@end
