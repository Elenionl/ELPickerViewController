//
//  ELPickerViewController.h
//  ELPickerViewController
//
//  Created by Elenion on 16/10/22.
//  Copyright © 2016年 Elenion. All rights reserved.
//

#import <UIKit/UIKit.h>

#define EL_PICKER_LENGTH(L) (L * EL_PICKER_SCREEN_WIDTH / EL_PICKER_TEMPELATE_WIDTH)
#define EL_PICKER_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define EL_PICKER_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define EL_PICKER_TEMPELATE_WIDTH 24.3f
#define EL_PICKER_SHADE_COLOR [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:0.8f]


typedef NS_ENUM(NSInteger, ELPickerViewStyle) {
  ELPickerViewStyleDefault,
  ELPickerViewStyleGender,
  ELPickerViewStyleMarriage,
  ELPickerViewStyleDate,
  ELPickerViewStyleYearAndMonth,
  ELPickerViewStyleCountry,
  ELPickerViewStyleIDCardStyle,
};
@interface ELPickerViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>

// Buttons
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *chooseButton;

- (instancetype)initWithViewController:(UIViewController *)viewController PickerViewStyle:(ELPickerViewStyle) style contentStrings:(NSArray<NSString *> *)strings keys:(NSArray<NSString *> *) keys pickCompletion:(void (^)(NSString * chosenString, NSString *chosenKey))pickCompletion;

@end
