//
//  Roue2ViewController.h
//  Roue02
//
//  Created by François PANARD on 28/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Roue2ViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UITextField *textView;
@end
