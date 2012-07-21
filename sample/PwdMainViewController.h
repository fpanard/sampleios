//
//  PwdMainViewController.h
//  Password
//
//  Created by François PANARD on 23/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PwdMainViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *passwordLength;
@property (strong, nonatomic) IBOutlet UISwitch *useLowercase;
@property (strong, nonatomic) IBOutlet UISwitch *useUppercase;
@property (strong, nonatomic) IBOutlet UISwitch *useNumber;
@property (strong, nonatomic) IBOutlet UISwitch *usePunctuation;
@property (strong, nonatomic) IBOutlet UIButton *generateButton;
@property (strong, nonatomic) IBOutlet UITextField *passwordResult;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)showInfo:(id)sender;
- (IBAction)generatePassword:(id)sender;
@end
