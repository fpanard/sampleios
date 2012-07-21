//
//  UtilQuizMainViewController.m
//  UtilQuiz
//
//  Created by François PANARD on 24/02/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "UtilQuizMainViewController.h"

@implementation UtilQuizMainViewController

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(UtilQuizFlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showInfo:(id)sender
{    
    UtilQuizFlipsideViewController *controller = [[UtilQuizFlipsideViewController alloc] initWithNibName:@"UtilQuizFlipsideViewController" bundle:nil];
    controller.delegate = self;
    //controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;	//UIModalTransitionStyleFlipHorizontal;
	controller.modalPresentationStyle = UIModalPresentationCurrentContext;
    //[self presentModalViewController:controller animated:YES];
	[self presentViewController:controller animated:YES completion:^
	{
		NSLog(@"Completion");
		[self.view setHidden:FALSE];
		[self.view setAlpha:1.0f];
		[controller.view setAlpha:0.5f];
	}];
}
@end
