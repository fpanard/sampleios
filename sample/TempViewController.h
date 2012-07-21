//
//  TempViewController.h
//  MultiConvertisseur
//
//  Created by François PANARD on 14/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TempViewController : UIViewController<UITextFieldDelegate>
- (IBAction)convertFer2Cent:(id)sender;
- (IBAction)convertCent2Fer:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *inputFer;
@property (weak, nonatomic) IBOutlet UITextField *inputCent;
@property (weak, nonatomic) IBOutlet UITextField *outputCent;
@property (weak, nonatomic) IBOutlet UITextField *outputFer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end
