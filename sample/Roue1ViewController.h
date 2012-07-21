//
//  Roue1ViewController.h
//  Roue01
//
//  Created by François PANARD on 27/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Roue1ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UITextField *textView;

- (IBAction)displayDate:(id)sender;
@end
