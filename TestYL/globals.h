//
//  globals.h
//  TestYL
//
//  Created by uBo on 03/06/2014.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import <Foundation/Foundation.h>


FOUNDATION_EXPORT NSString * const kStandartFontName;
FOUNDATION_EXPORT NSString * const kStandartFontNameBold;
FOUNDATION_EXPORT NSString * const kStandartMessageFontName;
FOUNDATION_EXPORT NSString * const kBaseUrl;
FOUNDATION_EXPORT NSUInteger const metersInKM;
FOUNDATION_EXPORT NSUInteger const birthDayMinValue;
FOUNDATION_EXPORT NSUInteger const birthDayMaxValue;

typedef NS_ENUM(NSUInteger, UserGender) {
    UserGenderNone = 0,
    UserGenderMale = 1,
    UserGenderFemale = 2,
    UserGenderPrivate = 3
};

#import <MapKit/MapKit.h>
#import <Masonry.h>
#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>

#import "UIView+FrameAdditions.h"
#import "MKMapView+ZoomLevel.h"
#import "MKCircleView+VeplayCommon.h"

#import "BBlock.h"

#import "BaseLabel.h"
#import "BaseUserAvatar.h"
#import "BaseUserAvatarView.h"

#import "YLDistance.h"
#import "YLDistanceTransformer.h"

