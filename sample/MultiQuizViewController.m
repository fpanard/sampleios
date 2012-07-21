//
//  MultiQuizViewController.m
//  sample
//
//  Created by François PANARD on 13/07/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "MultiQuizViewController.h"
#import "QuizFirstViewController.h"
#import "QuizSecondViewController.h"

@implementation MultiQuizViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	NSMutableArray *controllers = [[NSMutableArray alloc] init];
	
	[controllers addObject:[[QuizFirstViewController alloc] initWithNibName:@"QuizFirstViewController" bundle:nil]];
	[controllers addObject:[[QuizSecondViewController alloc] initWithNibName:@"QuizSecondViewController" bundle:nil]];
	for (int i = 0;i < 10;i++)
		[controllers addObject:[[QuizSecondViewController alloc] initWithNibName:@"QuizSecondViewController" bundle:nil]];
	self.viewControllers = controllers;
}
@end
