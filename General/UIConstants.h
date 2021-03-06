//
//  UIConstants.h
//  TestYL
//
//  Created by Georgi Ivanov on 7/5/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

// Sizes
extern CGFloat const CellHeight;

// Font names
extern NSString* const kLatoLight;
extern NSString* const kLatoBold;
extern NSString* const kLatoRegular;

// FXForm keys for cells
extern NSString* const kLabelFontPath;
extern NSString* const kLabelTextPath;
extern NSString* const kLabelColorPath;


// Fonts
extern UIFont* latoLightFont(CGFloat size);
extern UIFont* latoBoldFont(CGFloat size);
extern UIFont* latoRegularFont(CGFloat size);

// Colors
extern UIColor* formTextColor();

// Buttons
extern UIBarButtonItem* navigationBackButton(id target, SEL onTouch);
