//
//  FormController.h
//  TestYL
//
//  Created by Georgi Ivanov on 7/6/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import "BaseController.h"
#import "BaseFormController.h"

@interface FormController : BaseController

@property(nonatomic, assign) NSInteger formCellsCount;
@property(nonatomic, strong) UITableView* formTable;
@property(nonatomic, strong) BaseFormController* formController;

// animation properties
@property(nonatomic, assign) CGFloat formTableYDelta;

-(void)setupViews;

-(void)animateFormUp:(NSNotification*)notification;
-(void)animateFormDown:(NSNotification*)notification;

@end
