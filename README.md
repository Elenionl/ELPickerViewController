# ELPickerViewController
OBJ-C 可定制选择器

## Screenshots
![image](https://github.com/Elenionl/ELPickerViewController/blob/master/screenShot.gif)


## How to use

```objc
ELPickerViewController *controller = [[ELPickerViewController alloc] initWithViewController:self PickerViewStyle:REPickerViewStyleGender contentStrings:nil keys:nil pickCompletion:^(NSString *chosenString, NSString *chosenKey) {
  [sender setTitle:chosenString forState:UIControlStateNormal];
}];
[self.view addSubview:controller.view];
[self addChildViewController:controller];
```
If you are using style default, contentStrings are necessary, keys are not necessary.
If you are using other styles, contentStrings and keys should be nil. If you pass contentStrings or keys, it makes no difference.

The pick result will be given back in pickCompletion. The pickCompletion block will be executed exactly when the user tap the choose button.

## Summary

An easy-use and customizable picker view.

###custom

```objc
// default you can customize whatever you like
ELPickerViewController *controller = [[ELPickerViewController alloc] initWithViewController:self PickerViewStyle:REPickerViewStyleDefault contentStrings:@[@"choose 1", @"choose 2", @"choose 3", @"choose 4",] keys:@[@"1", @"2", @"3", @"4",] pickCompletion:^(NSString *chosenString, NSString *chosenKey) {
  [sender setTitle:chosenString forState:UIControlStateNormal];
  self.keyLabel.text = chosenKey;
}];
// gender picker
ELPickerViewController *controller = [[ELPickerViewController alloc] initWithViewController:self PickerViewStyle:REPickerViewStyleGender contentStrings:nil keys:nil pickCompletion:^(NSString *chosenString, NSString *chosenKey) {
    [sender setTitle:chosenString forState:UIControlStateNormal];
}];
// marriage status picker
ELPickerViewController *controller = [[ELPickerViewController alloc] initWithViewController:self PickerViewStyle:REPickerViewStyleMarriage contentStrings:nil keys:nil pickCompletion:^(NSString *chosenString, NSString *chosenKey) {
    [sender setTitle:chosenString forState:UIControlStateNormal];
}];
// date picker
ELPickerViewController *controller = [[ELPickerViewController alloc] initWithViewController:self PickerViewStyle:REPickerViewStyleDate contentStrings:nil keys:nil pickCompletion:^(NSString *chosenString, NSString *chosenKey) {
    [sender setTitle:chosenString forState:UIControlStateNormal];
}];
// year and month picker
ELPickerViewController *controller = [[ELPickerViewController alloc] initWithViewController:self PickerViewStyle:REPickerViewStyleYearAndMonth contentStrings:nil keys:nil pickCompletion:^(NSString *chosenString, NSString *chosenKey) {
    [sender setTitle:chosenString forState:UIControlStateNormal];
  }];
// country picker
ELPickerViewController *controller = [[ELPickerViewController alloc] initWithViewController:self PickerViewStyle:REPickerViewStyleCountry contentStrings:nil keys:nil pickCompletion:^(NSString *chosenString, NSString *chosenKey) {
  [sender setTitle:chosenString forState:UIControlStateNormal];
}];
// id card picker
ELPickerViewController *controller = [[ELPickerViewController alloc] initWithViewController:self PickerViewStyle:REPickerViewStyleIDCardStyle contentStrings:nil keys:nil pickCompletion:^(NSString *chosenString, NSString *chosenKey) {
    [sender setTitle:chosenString forState:UIControlStateNormal];
  }];
```


## Requirements

* iOS 8.0+
* ARC

## Author

@Elenionl, stallanxu@gmail.com

## License

English: ELPickerViewController is available under the MIT license, see the LICENSE file for more information.     
