//
//  ViewControllerSegue.m
//  TestYL
//
//  Created by Georgi Ivanov on 7/5/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import "ViewControllerSegue.h"
#import <POP.h>

@implementation ViewControllerSegue

-(void)perform {
    
    UIViewController *sourceViewController = (UIViewController*)[self sourceViewController];
    UIViewController *destinationController = (UIViewController*)[self destinationViewController];
    
    [sourceViewController.view addSubview:destinationController.view];
    
    CALayer *layer = destinationController.view.layer;
    [layer pop_removeAllAnimations];
    
    
    POPSpringAnimation *xAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    
    xAnim.fromValue = @([UIScreen mainScreen].bounds.size.width);
    xAnim.springBounciness = 15;
    xAnim.springSpeed = 10;
    
    xAnim.completionBlock = ^(POPAnimation *anim, BOOL finished){
        [destinationController.view removeFromSuperview];
        [sourceViewController.navigationController pushViewController:destinationController animated:NO];
    };
    
    [layer pop_addAnimation:xAnim forKey:@"position"];
}

@end
