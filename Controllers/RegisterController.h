//
//  RegisterController.h
//  TestYL
//
//  Created by Georgi Ivanov on 7/6/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import "FormController.h"
#import "RoundedButton.h"

@interface RegisterController : FormController

@property (weak, nonatomic) IBOutlet UIView *registerButtonContainer;
@property (weak, nonatomic) IBOutlet RoundedButton *addPhotoButton;

- (IBAction)addPhotoTapped:(id)sender;

-(void)setupViews;
-(BOOL)validateFormFields;

@end
