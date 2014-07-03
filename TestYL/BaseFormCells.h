//
//  BaseFormCells.h
//  GiveAway
//
//  Created by uBo on 15/04/2014.
//
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "FXForms.h"
#import "YLBirthDateModel.h"

@interface BaseFormCells : NSObject

@end

@interface FXFormDistanceCell : FXFormBaseCell

@property (nonatomic, readonly) UISlider *slider;

@end

@interface FXFormMapCell : FXFormBaseCell

@property (nonatomic, readonly) MKMapView *mapView;

@end

@interface FXFormBirthDateCell : FXFormBaseCell

@property (nonatomic, readonly) YLBirthDateModel *birthDate;

@end

@interface FXFormGenderCell : FXFormBaseCell

@property (nonatomic, readonly) NSUInteger gender;

@end

@interface FXFormTextCellWithIcon : FXFormTextFieldCell

@property (nonatomic, readonly) UIImageView *icon;

@end

@interface FXFormLocationsCell : FXFormTextFieldCell

@property (nonatomic, readonly) NSArray *locations;

@end
