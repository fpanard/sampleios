//
//  Roue4ViewController.h
//  Roue4
//
//  Created by François PANARD on 29/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import <UIKit/UIKit.h>

#define COMPONENT_RAYON			0
#define COMPONENT_OUVRAGE		1

@interface Roue4ViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIPickerView *libraryPicker;
@property (strong, nonatomic) IBOutlet UITextField *textView;
@end
