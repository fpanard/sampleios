//
//  LongViewController.h
//  MultiConvertisseur
//
//  Created by François PANARD on 14/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LongViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputValue;
@property (weak, nonatomic) IBOutlet UITextField *outputValue;
- (IBAction)convert:(id)sender;
@end
