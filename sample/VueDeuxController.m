//
//  VueDeuxController.m
//  MultiVues
//
//  Created by François PANARD on 06/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "MultiVuesViewController.h"
#import "VueDeuxController.h"

@implementation VueDeuxController
@synthesize rootController;

- (id)initWithRootController:(UIViewController *)controller
{
	if (!(self = [self initWithNibName:@"VueDeuxController" bundle:nil]))
		return nil;
	rootController = controller;
	return self;
}

- (void)changerVue:(id)sender
{
	UIView *rootView = [self.view superview];

	rootController.view.frame = self.view.frame;
	[UIView beginAnimations:@"ChangementVue" context:nil];
	[UIView setAnimationDuration:1.0f];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:rootView cache:YES];
	[self.rootController viewWillAppear:YES];
	[self viewWillDisappear:YES];
	[self.view removeFromSuperview];
	[rootView insertSubview:self.rootController.view atIndex:0];
	[self viewDidDisappear:YES];
	[self.rootController viewDidAppear:YES];
	[UIView commitAnimations];
}
@end
