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

@interface RegisterViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet RegisterController *registerController;
@property (nonatomic, strong) UIImage* pickedImage;

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
        [self.activityIndicator startAnimating];
        self.navigationItem.rightBarButtonItem.customView.hidden = YES;
        [self.accountService registerUser:[self.registerController userAccount] onSuccess:^(UserAccount *user) {
            
            [self.activityIndicator stopAnimating];
            [self.registerController hideFormDuration:0.4];
            [self showSecondPartOfRegistration];
            
        } onFailure:^(UserAccount *user, NSDictionary *error) {
            [self.activityIndicator stopAnimating];
            self.navigationItem.rightBarButtonItem.customView.hidden = NO;
            [self.registerController shakeFormBounciness:15 speed:30];
            NSLog(@"Fail %@", error);
        }];
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

-(void)makeUploadAvatarRequest
{
    [self.registerController.registerButton removeTarget:self action:@selector(registerTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.accountService uploadAvatar:self.pickedImage onSuccess:^(UserAccount *userWithNewAvatar) {
        
        [self performSegueWithIdentifier:@"inAppSegue" sender:userWithNewAvatar];
        self.pickedImage = nil;
        [self.registerController.registerButton addTarget:self action:@selector(registerTap:) forControlEvents:UIControlEventTouchUpInside];
        
    } onFailure:^(NSDictionary *error) {
        
        NSLog(@"%@", error);
        [self.registerController.registerButton addTarget:self action:@selector(registerTap:) forControlEvents:UIControlEventTouchUpInside];
        self.pickedImage = nil;
        
    }];
}

#pragma mark - ImagePicker Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.pickedImage = info[UIImagePickerControllerOriginalImage];
    [self.registerController.addPhotoButton setBackgroundImage:self.pickedImage forState:UIControlStateNormal];
    [self.registerController.addPhotoButton setBackgroundImage:self.pickedImage forState:UIControlStateHighlighted];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UI Actions

- (IBAction)registerTap:(id)sender {
    if(self.pickedImage)
    {
        [self makeUploadAvatarRequest];
    }
    else
    {
        [self performSegueWithIdentifier:@"inAppSegue" sender:[self.accountService userAccount]];
    }
    
}

- (IBAction)addPhotoTap:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}
@end
