//
//  CASample3ViewController.m
//  CASample3
//
//  Created by François PANARD on 29/08/11.
//  Copyright (c) 2011 FrPa. All rights reserved.
//

#import "EAGLView.h"
#import "CASample3ViewController.h"

@implementation CASample3ViewController
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"OpenGLES Sample";
	[(EAGLView *)self.view startAnimation];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) 
	    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    return YES;
}
@end
