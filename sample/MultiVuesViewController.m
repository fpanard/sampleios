//
//  MultiVuesViewController.m
//  MultiVues
//
//  Created by François PANARD on 06/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "VueDeuxController.h"
#import "MultiVuesViewController.h"

@implementation MultiVuesViewController
@synthesize vueDeuxController;

- (void)changerVue:(id)sender
{
	UIView *rootView = [self.view superview];

	if (!self.vueDeuxController)
		self.vueDeuxController = [[VueDeuxController alloc] initWithRootController:self];
	self.vueDeuxController.view.frame = self.view.frame;
	[UIView beginAnimations:@"ChangementVue" context:nil];
	[UIView setAnimationDuration:2.0f];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:rootView cache:YES];
	[self.vueDeuxController viewWillAppear:YES];
	[self viewWillDisappear:YES];
	[self.view removeFromSuperview];
	[rootView insertSubview:self.vueDeuxController.view atIndex:0];
	[self viewDidDisappear:YES];
	[self.vueDeuxController viewDidAppear:YES];
	[UIView commitAnimations];
	//[self.navigationController pushViewController:self.vueDeuxController animated:YES];
}

- (void)viewDidLoad
{
	self.title = @"Exemple d'application";
    [super viewDidLoad];
}
@end
