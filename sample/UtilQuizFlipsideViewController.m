//
//  UtilQuizFlipsideViewController.m
//  UtilQuiz
//
//  Created by François PANARD on 24/02/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "UtilQuizFlipsideViewController.h"

@implementation UtilQuizFlipsideViewController

@synthesize delegate = _delegate;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
