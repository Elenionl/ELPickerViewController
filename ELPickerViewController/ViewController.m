//
//  ViewController.m
//  ELPickerViewController
//
//  Created by Elenion on 16/10/22.
//  Copyright © 2016年 Elenion. All rights reserved.
//
#import <Masonry/Masonry.h>
#import "ViewController.h"
#import "ELPickerViewController.h"

@interface ViewController ()
@property (nonatomic, getter=isConstrainsSetup) BOOL constrainsSutup;


@property (nonatomic, strong) UIButton *defaultButton;
@property (nonatomic, strong) UIButton *genderButton;
@property (nonatomic, strong) UIButton *marriageButton;
@property (nonatomic, strong) UIButton *dateButton;
@property (nonatomic, strong) UIButton *yearAndMonthtButton;
@property (nonatomic, strong) UIButton *countryButton;
@property (nonatomic, strong) UIButton *idCardButton;
@property (nonatomic, strong) UILabel *keyLabel;


@end

@implementation ViewController

- (instancetype)init {
  if (self = [super init]) {
    self.constrainsSutup = NO;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.view addSubview:self.defaultButton];
  [self.view addSubview:self.genderButton];
  [self.view addSubview:self.marriageButton];
  [self.view addSubview:self.dateButton];
  [self.view addSubview:self.yearAndMonthtButton];
  [self.view addSubview:self.countryButton];
  [self.view addSubview:self.idCardButton];
  [self.view addSubview:self.keyLabel];
  [self.view setNeedsUpdateConstraints];
  [self.view updateConstraintsIfNeeded];
}

- (void)updateViewConstraints {
  if (!self.isConstrainsSetup) {
    self.constrainsSutup = YES;
    [self.keyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(self.defaultButton);
      make.top.equalTo(@(50));
      make.width.equalTo(self.defaultButton);
      make.height.equalTo(self.defaultButton);
    }];
    [self.defaultButton mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(@(0));
      make.top.equalTo(@(100));
      make.width.equalTo(@(200));
      make.height.equalTo(@(50));
    }];
    [self.marriageButton mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(self.defaultButton);
      make.top.equalTo(@(150));
      make.width.equalTo(self.defaultButton);
      make.height.equalTo(self.defaultButton);
    }];
    [self.dateButton mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(self.defaultButton);
      make.top.equalTo(@(200));
      make.width.equalTo(self.defaultButton);
      make.height.equalTo(self.defaultButton);
    }];
    [self.yearAndMonthtButton mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(self.defaultButton);
      make.top.equalTo(@(250));
      make.width.equalTo(self.defaultButton);
      make.height.equalTo(self.defaultButton);
    }];
    [self.countryButton mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(self.defaultButton);
      make.top.equalTo(@(300));
      make.width.equalTo(self.defaultButton);
      make.height.equalTo(self.defaultButton);
    }];
    [self.idCardButton mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(self.defaultButton);
      make.top.equalTo(@(350));
      make.width.equalTo(self.defaultButton);
      make.height.equalTo(self.defaultButton);
    }];
  }
  [super updateViewConstraints];
}

#pragma mark - Lazy Load
- (UIButton *)defaultButton {
  if (!_defaultButton) {
    _defaultButton = [[UIButton alloc] init];
    [_defaultButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_defaultButton setTitle:@"Default" forState:UIControlStateNormal];
    [_defaultButton addTarget:self action:@selector(showDefaultPickerViewByButton:) forControlEvents:UIControlEventTouchUpInside];
  }
  return _defaultButton;
}

- (UIButton *)genderButton {
  if (!_genderButton) {
    _genderButton = [[UIButton alloc] init];
    [_genderButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_genderButton setTitle:@"Gender" forState:UIControlStateNormal];
    [_genderButton addTarget:self action:@selector(showGenderPickerViewByButton:) forControlEvents:UIControlEventTouchUpInside];
  }
  return _genderButton;
}

- (UIButton *)marriageButton {
  if (!_marriageButton) {
    _marriageButton = [[UIButton alloc] init];
    [_marriageButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_marriageButton setTitle:@"Marriage" forState:UIControlStateNormal];
    [_marriageButton addTarget:self action:@selector(showMarriagePickerViewByButton:) forControlEvents:UIControlEventTouchUpInside];
  }
  return _marriageButton;
}

- (UIButton *)dateButton {
  if (!_dateButton) {
    _dateButton = [[UIButton alloc] init];
    [_dateButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_dateButton setTitle:@"Date" forState:UIControlStateNormal];
    [_dateButton addTarget:self action:@selector(showDatePickerViewByButton:) forControlEvents:UIControlEventTouchUpInside];
  }
  return _dateButton;
}

- (UIButton *)yearAndMonthtButton {
  if (!_yearAndMonthtButton) {
    _yearAndMonthtButton = [[UIButton alloc] init];
    [_yearAndMonthtButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_yearAndMonthtButton setTitle:@"YearAndMonth" forState:UIControlStateNormal];
    [_yearAndMonthtButton addTarget:self action:@selector(showYearAndMonthPickerViewByButton:) forControlEvents:UIControlEventTouchUpInside];
  }
  return _yearAndMonthtButton;
}

- (UIButton *)countryButton {
  if (!_countryButton) {
    _countryButton = [[UIButton alloc] init];
    [_countryButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_countryButton setTitle:@"Country" forState:UIControlStateNormal];
    [_countryButton addTarget:self action:@selector(showCountryPickerViewByButton:) forControlEvents:UIControlEventTouchUpInside];
  }
  return _countryButton;
}

- (UIButton *)idCardButton {
  if (!_idCardButton) {
    _idCardButton = [[UIButton alloc] init];
    [_idCardButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_idCardButton setTitle:@"IDCard" forState:UIControlStateNormal];
    [_idCardButton addTarget:self action:@selector(showIDCardPickerViewByButton:) forControlEvents:UIControlEventTouchUpInside];
  }
  return _idCardButton;
}

- (UILabel *)keyLabel {
  if (!_keyLabel) {
    _keyLabel = [[UILabel alloc] init];
    _keyLabel.text = @"key";
    _keyLabel.textAlignment = NSTextAlignmentCenter;
  }
  return _keyLabel;
}

#pragma mark - Button Tapped

- (void)showDefaultPickerViewByButton:(UIButton *)sender {
  ELPickerViewController *controller = [[ELPickerViewController alloc] initWithViewController:self PickerViewStyle:ELPickerViewStyleDefault contentStrings:@[@"choose 1", @"choose 2", @"choose 3", @"choose 4",] keys:@[@"1", @"2", @"3", @"4",] pickCompletion:^(NSString *chosenString, NSString *chosenKey) {
    [sender setTitle:chosenString forState:UIControlStateNormal];
    self.keyLabel.text = chosenKey;
  }];
  [self.view addSubview:controller.view];
  [self addChildViewController:controller];
}

- (void)showGenderPickerViewByButton:(UIButton *)sender {
  ELPickerViewController *controller = [[ELPickerViewController alloc] initWithViewController:self PickerViewStyle:ELPickerViewStyleGender contentStrings:nil keys:nil pickCompletion:^(NSString *chosenString, NSString *chosenKey) {
    [sender setTitle:chosenString forState:UIControlStateNormal];
  }];
  [self.view addSubview:controller.view];
  [self addChildViewController:controller];
}

- (void)showMarriagePickerViewByButton:(UIButton *)sender {
  ELPickerViewController *controller = [[ELPickerViewController alloc] initWithViewController:self PickerViewStyle:ELPickerViewStyleMarriage contentStrings:nil keys:nil pickCompletion:^(NSString *chosenString, NSString *chosenKey) {
    [sender setTitle:chosenString forState:UIControlStateNormal];
  }];
  [self.view addSubview:controller.view];
  [self addChildViewController:controller];
}

- (void)showDatePickerViewByButton:(UIButton *)sender {
  ELPickerViewController *controller = [[ELPickerViewController alloc] initWithViewController:self PickerViewStyle:ELPickerViewStyleDate contentStrings:nil keys:nil pickCompletion:^(NSString *chosenString, NSString *chosenKey) {
    [sender setTitle:chosenString forState:UIControlStateNormal];
  }];
  [self.view addSubview:controller.view];
  [self addChildViewController:controller];
}

- (void)showYearAndMonthPickerViewByButton:(UIButton *)sender {
  ELPickerViewController *controller = [[ELPickerViewController alloc] initWithViewController:self PickerViewStyle:ELPickerViewStyleYearAndMonth contentStrings:nil keys:nil pickCompletion:^(NSString *chosenString, NSString *chosenKey) {
    [sender setTitle:chosenString forState:UIControlStateNormal];
  }];
  [self.view addSubview:controller.view];
  [self addChildViewController:controller];
}

- (void)showCountryPickerViewByButton:(UIButton *)sender {
  ELPickerViewController *controller = [[ELPickerViewController alloc] initWithViewController:self PickerViewStyle:ELPickerViewStyleCountry contentStrings:nil keys:nil pickCompletion:^(NSString *chosenString, NSString *chosenKey) {
    [sender setTitle:chosenString forState:UIControlStateNormal];
  }];
  [self.view addSubview:controller.view];
  [self addChildViewController:controller];
}

- (void)showIDCardPickerViewByButton:(UIButton *)sender {
  ELPickerViewController *controller = [[ELPickerViewController alloc] initWithViewController:self PickerViewStyle:ELPickerViewStyleIDCardStyle contentStrings:nil keys:nil pickCompletion:^(NSString *chosenString, NSString *chosenKey) {
    [sender setTitle:chosenString forState:UIControlStateNormal];
  }];
  [self.view addSubview:controller.view];
  [self addChildViewController:controller];
}

@end
