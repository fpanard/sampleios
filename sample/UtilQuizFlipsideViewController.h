//
//  UtilQuizFlipsideViewController.h
//  UtilQuiz
//
//  Created by François PANARD on 24/02/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UtilQuizFlipsideViewController;

@protocol UtilQuizFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(UtilQuizFlipsideViewController *)controller;
@end

@interface UtilQuizFlipsideViewController : UIViewController

@property (weak, nonatomic) id <UtilQuizFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
