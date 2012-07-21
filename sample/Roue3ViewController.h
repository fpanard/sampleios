//
//  Roue3ViewController.h
//  Roue3
//
//  Created by François PANARD on 28/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import <UIKit/UIKit.h>

#define COMPONENT_VILLES		0
#define COMPONENT_SERVICES		1

@interface Roue3ViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UITextField *textView;
@end
