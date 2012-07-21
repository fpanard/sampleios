//
//  SliderViewController.h
//  Slider
//
//  Created by François PANARD on 26/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SliderViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISlider *sliderView;
@property (strong, nonatomic) IBOutlet UITextField *textView;
@property (strong, nonatomic) IBOutlet UIView *colorView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)sliderChanged:(id)sender;
- (IBAction)displayValue:(id)sender;
- (IBAction)colorChanged:(id)sender;
@end
