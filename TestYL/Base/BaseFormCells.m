//
//  BaseFormCells.m
//  GiveAway
//
//  Created by uBo on 15/04/2014.
//
//

#import "BaseFormCells.h"
#import "BaseMapImageOverlay.h"
#import "BaseMapImageOverlayView.h"
#import "BaseSegment.h"
#import "YLSliderValues.h"

@implementation BaseFormCells

@end

@interface FXFormDistanceCell ()

@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UILabel *distance;
@property (nonatomic, strong) NSString *previousSliderValue;

@end


@implementation FXFormDistanceCell

- (void)setUp
{
    self.slider = [[UISlider alloc] init];
    [self.slider addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.slider];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.distance = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 0, 0)];
    self.distance.backgroundColor = [UIColor clearColor];
    self.distance.font = [UIFont fontWithName:kStandartFontNameBold size:24];
    self.distance.textColor = [UIColor colorWithHexValue:@"#116bc9" alpha:1.0];
    self.distance.textAlignment = NSTextAlignmentCenter;
    
    self.distance.text = @"8 km";
    
    [self.contentView addSubview:self.distance];
    
    [self.distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.slider.mas_right);
        make.right.equalTo(@0);
        make.top.equalTo(@7);
    }];
    
    UILabel *rangeText = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                   self.distance.frame.origin.y + self.distance.frame.size.height, self.distance.frame.size.width,
                                                                   20)];
    rangeText.backgroundColor = [UIColor clearColor];
    rangeText.font = [UIFont fontWithName:kStandartFontName size:12];
    rangeText.textColor = [UIColor colorWithHexValue:@"#a9a9a9" alpha:1.0];
    rangeText.textAlignment = NSTextAlignmentCenter;
    rangeText.text = NSLocalizedString(@"range", @"");
    
    [self.contentView addSubview:rangeText];
    
    [rangeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.distance.mas_centerX);
        make.top.equalTo(self.distance.mas_bottom);
    }];
    
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@(-100));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
}

+ (CGFloat)heightForField:(FXFormField *)field {
    return 58;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect sliderFrame = self.slider.frame;
    sliderFrame.origin.x = self.textLabel.frame.origin.x + self.textLabel.frame.size.width + 10;
    sliderFrame.origin.y = (self.contentView.frame.size.height - sliderFrame.size.height) / 2;
    sliderFrame.size.width = self.contentView.bounds.size.width - sliderFrame.origin.x - 10;
    self.slider.frame = sliderFrame;
    
    self.contentView.$height = self.slider.$height + 2*12;
}

- (void)update
{
    self.textLabel.text = self.field.title;
    
    YLSliderValues *values = (YLSliderValues *)self.field.value;
    
    self.slider.minimumValue = values.minValue;
    self.slider.maximumValue = values.maxValue;
    self.slider.value = values.currentValue;

    [self valueChanged];
}

- (void)valueChanged
{
    ((YLSliderValues *)self.field.value).currentValue = self.slider.value;
    if (self.field.action) self.field.action(self);
    
    NSString *val = [NSString stringWithFormat:@"%.0f", self.slider.value];
    
    self.distance.text = [YLDistanceTransformer distanceTextFromMeters:[YLDistanceTransformer distanceFromSliderPosition:[val floatValue]]];
    
    if ( self.previousSliderValue == nil || ![self.previousSliderValue isEqualToString:val] ) {
        self.previousSliderValue = val;
        
        [[NSNotificationCenter defaultCenter]
         postNotification:[NSNotification notificationWithName:@"FXFormDistanceChanged" object:nil userInfo:@{@"slider": self.slider}]];
    }
}

@end

@interface FXFormMapCell () <MKMapViewDelegate>

@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, assign) CGFloat radius;

@end

@implementation FXFormMapCell

- (void)setUp
{
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 75)];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    
    [self.contentView addSubview:self.mapView];
    
    UIView *overlayGrid = [[UIView alloc] init];
    overlayGrid.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"overlay-grid.png"]];
    overlayGrid.frame = self.mapView.bounds;
    overlayGrid.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    [self.contentView addSubview:overlayGrid];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(fieldValueChanged:) name:@"FXFormDistanceChanged" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)fieldValueChanged:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    UISlider *slider = (UISlider *)userInfo[@"slider"];
    
    self.radius = ((CGFloat)[YLDistanceTransformer distanceFromSliderPosition:[[NSString stringWithFormat:@"%.0f", slider.value] floatValue]]/metersInKM);
    
    [self valueChanged];
    [self update];
}

- (void)update
{
    YLDistance *distance = (YLDistance *)self.field.value;
    
    self.location = distance.location;
    self.radius = distance.radius;
    
    [self.mapView setCenterCoordinate:self.location.coordinate zoomLevel:13 animated:NO];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.location.coordinate, (self.radius*metersInKM)*2.5, (self.radius*metersInKM)*2.5);
    
    [self.mapView setRegion:region animated:YES];
    
    [self setRadiusOverlay];
    
    [self setNeedsLayout];
}

+ (CGFloat)heightForField:(FXFormField *)field {
    // TODO - dynamic
    return 364;
}

- (void)valueChanged
{
    YLDistance *distance = (YLDistance *)self.field.value;
    distance.radius = self.radius;
    
    if (self.field.action) self.field.action(self);
}

- (void)setRadiusOverlay {
    [self removeRadiusOverlay];
    
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:self.location.coordinate radius:self.radius*metersInKM];
    
    [self.mapView addOverlay:circle];
}

- (void)removeRadiusOverlay {
    for (id overlay in [self.mapView overlays]) {
        if ([overlay isKindOfClass:[MKCircle class]]) {
            [self.mapView removeOverlay:overlay];
        }
    }
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id)overlay {
    if ( [overlay isKindOfClass:[MKCircle class]] ) {
        return [MKCircleView redCircleWithOverlay:overlay];
    }
    
    if ( [overlay isKindOfClass:[BaseMapImageOverlay class]] ) {
        BaseMapImageOverlayView *overlayGrid = [[BaseMapImageOverlayView alloc] initWithOverlay:overlay];
    
        return overlayGrid;
    }
    
    return nil;
}

@end


@interface FXFormBirthDateCell () <UITextFieldDelegate>

@property (nonatomic, strong) UIView *birthDayPicker;
@property (nonatomic, strong) UISwitch *birthdayPublicSwitch;
@property (nonatomic, strong) UITextField *birthDayField;
@property (nonatomic, weak) UIView *parent;
@property (nonatomic, strong) NSDate *birthDateSelected;

@end

@implementation FXFormBirthDateCell

@synthesize birthDayPicker, birthDate = _birthDate, birthDateSelected = _birthDateSelected, birthDayField, birthdayPublicSwitch;
@synthesize parent;

- (void)setUp
{
    birthDayField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, self.contentView.$width/2, self.contentView.$height)];
    birthDayField.delegate = self;
    
    [self.contentView addSubview:birthDayField];
    
    UILabel *title = [[UILabel alloc] init];
    title.numberOfLines = 1;
    title.font = [UIFont fontWithName:kStandartMessageFontName size:17];
    title.textColor = [UIColor blackColor];
    title.text = NSLocalizedString(@"Public", @"");
    
    [self.contentView addSubview:title];
    
    birthdayPublicSwitch = [[UISwitch alloc] init];
    [self.birthdayPublicSwitch addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];
    
    [self.contentView addSubview:birthdayPublicSwitch];
    
    [birthdayPublicSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-10));
        make.centerY.equalTo(self.contentView);
    }];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(birthdayPublicSwitch);
        make.right.equalTo(birthdayPublicSwitch.mas_left).with.offset(-10);
    }];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ( textField == self.birthDayField ) {
        [self showDatePicker:nil];
        
        return NO;
    }
    
    [self cancelDateSet:nil];
    
    return YES;
}

- (void)update
{
    self.birthDateSelected = ((YLBirthDateModel *)self.field.value).birthDate;
    
    self.birthdayPublicSwitch.on = ((YLBirthDateModel *)self.field.value).birthDatePublic;
    
    [self setDateFieldText];
    
    [self setNeedsLayout];
}

- (void)valueChanged
{
    ((YLBirthDateModel *)self.field.value).birthDate = self.birthDateSelected;
    ((YLBirthDateModel *)self.field.value).birthDatePublic = self.birthdayPublicSwitch.on;
    
    if (self.field.action) self.field.action(self);
}

#pragma mark - Date Picker

- (void)showDatePicker:(id)sender {
	
	birthDayPicker = [[UIView alloc] init];
    birthDayPicker.backgroundColor = [UIColor colorWithHexValue:@"#ffffff" alpha:1.0];
	
    CGRect pickerFrame = CGRectMake(0, 44, 0, 0);
	
    UIDatePicker *datePickerView = [[UIDatePicker alloc] initWithFrame:pickerFrame];
	[datePickerView setDatePickerMode:UIDatePickerModeDate];
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps = [[NSDateComponents alloc] init];
	
	[comps setYear:-birthDayMaxValue];
	NSDate *dateMin = [gregorian dateByAddingComponents:comps toDate:[NSDate date] options:0];
	
	[comps setYear:-birthDayMinValue];
	NSDate *dateMax = [gregorian dateByAddingComponents:comps toDate:[NSDate date] options:0];
	
	datePickerView.minimumDate = dateMin;
	datePickerView.maximumDate = dateMax;
	
	if ( self.birthDateSelected != nil ) {
		dateMax = self.birthDateSelected;
	}
	
	[datePickerView setDate:dateMax animated:YES];
	
    [self.birthDayPicker addSubview:datePickerView];
	
	UIToolbar *controllToolbar = [[UIToolbar alloc]  initWithFrame:CGRectMake(0, 0, datePickerView.bounds.size.width, 44)];
	[controllToolbar setBarStyle:UIBarStyleBlack];
	[controllToolbar sizeToFit];
	
	UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:nil action: nil];
	UIBarButtonItem *setButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Set", @"Set birthday date") style:UIBarButtonItemStyleDone target: self action: @selector(dismissDateSet:)];
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(cancelDateSet:)];
	
	[controllToolbar setItems:[NSArray arrayWithObjects:spacer, cancelButton, setButton, nil] animated: NO];
	
	
	[self.birthDayPicker addSubview:controllToolbar];
	
    [self.birthDayPicker setFrame:CGRectMake(0, self.parent.$height, self.parent.$width, 260)];
    
    [self.parent addSubview:self.birthDayPicker];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.birthDayPicker.$y = self.parent.$height - 260;
    }];
}

- (void)setDateFieldText {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MM/dd/yyyy"];
    
	[self.birthDayField setText:[dateFormatter stringFromDate:self.birthDateSelected]];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ( [key isEqualToString:@"parent"] ) {
        self.parent = (UIView *)value;
    }
}

- (void)dismissDateSet:(id)sender {
	NSArray *listOfViews = [self.birthDayPicker subviews];
	
	for (UIView *subView in listOfViews) {
		if ([subView isKindOfClass:[UIDatePicker class]]) {
			self.birthDateSelected = [(UIDatePicker *)subView date];
			break;
		}
	}
    
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MM/dd/yyyy"];
	[self.birthDayField setText:[dateFormatter stringFromDate:self.birthDateSelected]];
	
	[self cancelDateSet:nil];
    
    [self valueChanged];
}

- (void)cancelDateSet:(id)sender {
	[UIView animateWithDuration:0.3 animations:^{
        self.birthDayPicker.$y = self.parent.$height;
    } completion:^(BOOL finished) {
        [self.birthDayPicker removeFromSuperview];
        
        self.birthDayPicker = nil;
    }];
}

@end

@interface FXFormGenderCell ()

@property (nonatomic, strong) BaseSegment *segment;

@end

@implementation FXFormGenderCell

@synthesize segment = _segment;

- (void)setUp {
    NSArray *items = @[NSLocalizedString(@"Male", @""), NSLocalizedString(@"Female", @""), NSLocalizedString(@"Private", @"")];
    
    _segment = [[BaseSegment alloc] initWithItems:items];
    
    [self.segment addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];
    
    [self.segment gender];
    
    [self.contentView addSubview:self.segment];
    
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)update {
    self.segment.selectedSegmentIndex = [self.field.value integerValue] - 1;
}

- (void)valueChanged
{
    self.field.value = @(self.segment.selectedSegmentIndex + 1);
    
    if (self.field.action) self.field.action(self);
}

@end

@implementation FXFormTextCellWithIcon

@synthesize icon = _icon;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ) {
    
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    
        [self.contentView addSubview:self.icon];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.icon.center = self.textField.center;
    self.icon.$x = 10;
    
    self.textField.$x = self.icon.$x + self.icon.$width + 6;
    self.textField.$width = self.textField.$width - (self.icon.$x + self.icon.$width + 10);
}

@end

@interface FXFormLocationsCell ()

@property (nonatomic, strong) UIImageView *icon;

@end

@implementation FXFormLocationsCell

@synthesize locations = _locations;
@synthesize icon = _icon;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ) {
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        
        [self.contentView addSubview:self.icon];
    }
    
    return self;
}

- (void)update
{
    NSArray *locations = (NSArray *)self.field.value;
    
    NSUInteger index = 0;
    for (BaseLabel *locationLabel in locations) {
        [self.contentView addSubview:locationLabel];
        
        [locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            if ( index == 0 ) {
                make.left.equalTo(self.icon.mas_right).with.offset(5);
            } else {
                make.left.equalTo(((BaseLabel *)locations[index-1]).mas_right).with.offset(5);
            }
            
            make.centerY.equalTo(self.icon);
        }];
        
        index++;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.icon.center = self.textField.center;
    self.icon.$x = 10;
    
    self.textField.$x = self.icon.$x + self.icon.$width + 6;
    self.textField.$width = self.textField.$width - (self.icon.$x + self.icon.$width + 10);
}

@end
