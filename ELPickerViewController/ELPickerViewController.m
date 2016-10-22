//
//  ELPickerViewController.m
//  ELPickerViewController
//
//  Created by Elenion on 16/10/22.
//  Copyright © 2016年 Elenion. All rights reserved.
//
#import <Masonry/Masonry.h>
#import "ELPickerViewController.h"

@interface ELPickerViewController ()

// Picker View
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIDatePicker *datePickerView;
// Buttons
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *chooseButton;
// Other Views
@property (nonatomic, strong) UIView *frontView;
// Settings
@property (nonatomic, getter=isConstrainsSetup) BOOL constrainsSutup;
@property (nonatomic) REPickerViewStyle style;
@property(nonatomic,copy) void (^pickCompletion) (NSString * chosenString, NSString *chosenKey);
// Title Array
@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, strong) NSArray<NSString *> *subTitles;
@property (nonatomic, strong) NSArray<NSString *> *defaultTitles;
@property (nonatomic, strong) NSArray<NSString *> *defaultKeys;
// Chosen
@property (nonatomic, copy) NSString *chosenTitle;
@property (nonatomic, copy) NSString *chosenSubTitle;
@property (nonatomic, copy) NSString *chosenKey;

@end

@implementation ELPickerViewController

- (instancetype)initWithViewController:(UIViewController *)viewController PickerViewStyle:(REPickerViewStyle)style contentStrings:(NSArray<NSString *> *)strings keys:(NSArray<NSString *> *)keys pickCompletion:(void (^)(NSString *, NSString *))pickCompletion {
  
  if (self = [super init]) {
    self.style = style;
    self.defaultTitles = strings;
    self.defaultKeys = keys;
    self.pickCompletion = pickCompletion;
    [self commonInit];
  }
  return self;
}

- (void) commonInit {
  self.constrainsSutup = NO;
  UITapGestureRecognizer* tapBackground = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAnimation)];
  [tapBackground setNumberOfTapsRequired:1];
  [self.view addGestureRecognizer:tapBackground];
  
  
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupViews];
  [self.view setNeedsUpdateConstraints];
  [self.view updateConstraintsIfNeeded];
  // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
  [self showAnimation];
}

- (void)setupViews {
  self.view.backgroundColor = EL_PICKER_SHADE_COLOR;
  [self.view addSubview:self.frontView];
  [self.frontView addSubview:self.chooseButton];
  [self.frontView addSubview:self.cancelButton];
  if (self.style == REPickerViewStyleDate) {
    [self.frontView addSubview:self.datePickerView];
  }
  else {
    [self.frontView addSubview:self.pickerView];
  }
}

- (void)updateViewConstraints {
  if (!self.isConstrainsSetup) {
    self.constrainsSutup = YES;
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.frontView.mas_left).with.offset(EL_PICKER_SCREEN_WIDTH - EL_PICKER_LENGTH(6));
      make.top.equalTo(@(EL_PICKER_LENGTH(0.8)));
      make.width.equalTo(@(EL_PICKER_LENGTH(6)));
      make.height.equalTo(@(EL_PICKER_LENGTH(1.0)));
    }];
    [self.chooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.frontView.mas_left);
      make.top.equalTo(@(EL_PICKER_LENGTH(0.8)));
      make.width.equalTo(@(EL_PICKER_LENGTH(6)));
      make.height.equalTo(@(EL_PICKER_LENGTH(1.0)));
    }];
    if (self.style == REPickerViewStyleDate) {
      [self.datePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(self.cancelButton.mas_bottom);
        make.width.equalTo(@(EL_PICKER_SCREEN_WIDTH));
        make.bottom.equalTo(@(0));
      }];
    }
    else {
      [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(self.cancelButton.mas_bottom);
        make.width.equalTo(@(EL_PICKER_SCREEN_WIDTH));
        make.bottom.equalTo(@(0));
      }];
    }
  }
  [super updateViewConstraints];
}
#pragma mark - Lazy Load

- (UIPickerView *)pickerView {
  if (!_pickerView && !(self.style == REPickerViewStyleDate)) {
    _pickerView = [[UIPickerView alloc] init];
    _pickerView.backgroundColor = [UIColor clearColor];
    _pickerView.delegate = self;
    _pickerView.dataSource  = self;
  }
  return _pickerView;
}

- (UIDatePicker *)datePickerView {
  if (!_datePickerView && (self.style == REPickerViewStyleDate)) {
    _datePickerView = [[UIDatePicker alloc] init];
    _datePickerView.backgroundColor = [UIColor clearColor];
    _datePickerView.datePickerMode = UIDatePickerModeDate;
    _datePickerView.date = [NSDate date];
    [self.datePickerView addTarget:self action:@selector(datePickerChange:) forControlEvents:UIControlEventValueChanged];
  }
  return _datePickerView;
}

- (UIButton *)chooseButton {
  if (!_chooseButton) {
    _chooseButton = [[UIButton alloc] init];
    [self.chooseButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.chooseButton setTitle:@"Choose" forState:UIControlStateNormal];
    [self.chooseButton addTarget:self action:@selector(didTapChooseButton:) forControlEvents:UIControlEventTouchUpInside];
  }
  return _chooseButton;
}

- (UIButton *)cancelButton {
  if (!_cancelButton) {
    _cancelButton = [[UIButton alloc] init];
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(didTapCancelButton:) forControlEvents:UIControlEventTouchUpInside];
  }
  return _cancelButton;
}

- (UIView *)frontView {
  if (!_frontView) {
    _frontView = [[UIView alloc] init];
    _frontView.backgroundColor = [UIColor whiteColor];
    _frontView.frame = CGRectMake(0, EL_PICKER_SCREEN_HEIGHT, EL_PICKER_SCREEN_WIDTH, EL_PICKER_SCREEN_HEIGHT / 3);
  }
  return _frontView;
  
}

- (NSArray<NSString *> *)titles {
  if (!_titles) {
    NSArray *titles;
    switch (self.style) {
      case REPickerViewStyleDefault: {
        titles = self.defaultTitles;
        break;
      }
      case REPickerViewStyleGender: {
        titles = @[
                   @"Male",
                   @"Female",
                   ];
        break;
      }
      case REPickerViewStyleMarriage: {
        titles = @[
                   @"Unmarried",
                   @"Married",
                   @"Windowed",
                   @"Divorced",
                   @"Others",
                   ];
        break;
      }
      case REPickerViewStyleCountry: {
        titles = @[
                   @"Macau",
                   @"Hong Kong",
                   @"China",
                   @"Republic of China",
                   @"Vietnam",
                   @"Korea",
                   @"Japan",
                   @"Thailand",
                   @"Malaysia",
                   @"Philippines",
                   @"India",
                   @"Indonesia",
                   @"Kuwait",
                   @"Pakistan",
                   @"Maldives",
                   @"Iran",
                   @"Iraq",
                   @"Israel",
                   @"Saudi-arabia",
                   @"Singapore",
                   @"Papua New Guinea",
                   @"Nepal",
                   @"Yemen",
                   @"Turkey",
                   @"Solomon Islands",
                   @"Sri Lanka",
                   @"United States",
                   @"Canada",
                   @"Brazil",
                   @"Argentina",
                   @"Chile",
                   @"Colombia",
                   @"Dominican",
                   @"Panama",
                   @"Honduras",
                   @"Nicaragua",
                   @"Ecuador",
                   @"Mexico",
                   @"Uruguay",
                   @"Peru",
                   @"Guatemala",
                   @"Costa Rica",
                   @"El Salvador",
                   @"Australia",
                   @"Palau",
                   @"Fiji",
                   @"Guam",
                   @"New Zealand",
                   @"Portugal",
                   @"Spain",
                   @"Sweden",
                   @"Switzerland",
                   @"United Kingdom",
                   @"Germany",
                   @"France",
                   @"Russia",
                   @"Hungary",
                   @"Iceland",
                   @"Ireland",
                   @"Malta",
                   @"Greece",
                   @"Italy",
                   @"Luxembourg",
                   @"Morocco",
                   @"Netherlands",
                   @"Norway",
                   @"Poland",
                   @"Romania",
                   @"Austria",
                   @"Belgium",
                   @"Denmark",
                   @"Finland",
                   @"Norocco",
                   @"Nigeria",
                   @"South Africa",
                   @"Kenya",
                   @"Tansaniya",
                   @"Algeria",
                   @"Egypt",
                   ];
        break;
      case REPickerViewStyleYearAndMonth: {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy";
        NSString *currentYear = [formatter stringFromDate:[NSDate date]];
        NSMutableArray *yearArray = [[NSMutableArray alloc] init];
        for (NSInteger year = currentYear.integerValue - 60; year < currentYear.integerValue + 2; year++) {
          [yearArray addObject:@(year).stringValue];
        }
        titles = [yearArray copy];
        self.subTitles = @[
                           @"01",
                           @"02",
                           @"03",
                           @"04",
                           @"05",
                           @"06",
                           @"07",
                           @"08",
                           @"09",
                           @"10",
                           @"11",
                           @"12",
                           ];
      }
        break;
      }
      case REPickerViewStyleIDCardStyle: {
        titles = @[
                   @"ID Card",
                   @"Driver License",
                   @"Green Card",
                   ];
        break;
      }
      default:
        break;
        
    }
    _titles = titles;
    if (self.style == REPickerViewStyleYearAndMonth) {
      self.chosenSubTitle = @"01";
      self.chosenTitle = [self.titles firstObject];
    }
    else {
      self.chosenTitle = [self.titles firstObject];
    }
  }
  return _titles;
}

#pragma mark - Button Tapped

- (void)didTapChooseButton:(UIButton *) button {
  NSLog(@"choose");
  if (_chosenTitle.length) {
    if (self.style == REPickerViewStyleYearAndMonth) {
      NSString *date = [NSString stringWithFormat:@"%@/%@", self.chosenSubTitle, self.chosenTitle];
      self.pickCompletion(date, nil);
    }
    else {
      self.pickCompletion(self.chosenTitle, self.chosenKey);
    }
    
  }
  [self hideAnimation];
}

- (void)didTapCancelButton:(UIButton *) button {
  NSLog(@"cancel");
  [self hideAnimation];
}

#pragma mark - Animation

- (void)showAnimation {
  [UIView animateWithDuration:0.5 animations:^{
    CGRect frame = self.frontView.frame;
    frame.origin.y = EL_PICKER_SCREEN_HEIGHT * 2 / 3;
    self.frontView.frame = frame;
  }];
}

- (void)hideAnimation {
  [UIView animateWithDuration:0.5 animations:^{
    
  }];
  
  [UIView animateWithDuration:0.5 animations:^{
    CGRect frame = self.frontView.frame;
    frame.origin.y = EL_PICKER_SCREEN_HEIGHT;
    self.frontView.frame = frame;
  } completion:^(BOOL finished) {
    [self.frontView removeFromSuperview];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
  }];
}

#pragma mark - UIPickerViewDelegate DataSource

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  if (self.style == REPickerViewStyleYearAndMonth) {
    switch (component) {
      case 0:
        return self.titles.count;
      case 1:
        return self.subTitles.count;
      default:
        break;
    }
  }
  return self.titles.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  if (self.style == REPickerViewStyleYearAndMonth) {
    return 2;
  }
  return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  if (self.style == REPickerViewStyleYearAndMonth) {
    switch (component) {
      case 0:
        return self.titles[row];
      case 1:
        return self.subTitles[row];
      default:
        break;
    }
  }
  return NSLocalizedString((NSString *)self.titles[row], nil);
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  if (self.style == REPickerViewStyleYearAndMonth) {
    switch (component) {
      case 0:
        self.chosenTitle = self.titles[row];
        break;
      case 1:
        self.chosenSubTitle = self.subTitles[row];
        break;
      default:
        break;
    }
  }
  else {
    self.chosenTitle = self.titles[row];
    if (self.style == REPickerViewStyleDefault) {
      self.chosenKey = self.defaultKeys[row];
    }
  }
  NSLog(@"%@", self.chosenTitle);
}

#pragma mark - Private Methods

- (void)datePickerChange:(UIDatePicker *)paramPicker{
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  formatter.dateFormat = @"yyyy-MM-dd";
  NSString *dateString = [formatter stringFromDate:paramPicker.date];
  self.chosenTitle = dateString;
  NSLog(@"Selected date = %@", dateString);
}


@end
