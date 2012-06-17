//
//  CASample1ViewController.m
//  CASample1
//
//  Created by François PANARD on 23/08/11.
//  Copyright 2011 FrPa. All rights reserved.
//

#import "CASample1ViewController.h"

@implementation CASample1ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	self.title = @"Box gesture";
	[super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
@end
