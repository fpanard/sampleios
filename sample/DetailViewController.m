//
//  DetailViewController.m
//  sample
//
//  Created by François PANARD on 04/09/11.
//  Copyright 2011 FrPa. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController()
@property (nonatomic) UIPopoverController *masterPopoverController;
@end

@implementation DetailViewController
@synthesize masterPopoverController = _masterPopoverController;
@synthesize currentController = _currentController;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)loadDetailView:(NSString *)nibName name:(NSString *)name
{
	UIViewController *controller = [[UIViewController alloc] initWithNibName:nibName bundle:nil];
	
	[self loadDetailController:controller name:name];
	if (!name)
		self.title = nibName;
}

- (void)loadDetailController:(UIViewController*)controller name:(NSString *)name
{
	UIViewController *previousController = self.currentController;
	
	self.currentController = controller;
	
	// Gestion hiérarchie des controllers
	
	[self addChildViewController:controller];
	[self.view addSubview:self.currentController.view];
	[controller didMoveToParentViewController:self];
	self.currentController.view.frame = self.view.bounds;
	
	if (name)
		self.title = name;
	else
		self.title = self.currentController.title;
	
	// Gestion hiérarchie des controller
	
	[previousController willMoveToParentViewController:nil];
	[previousController.view removeFromSuperview];				// Il faut supprimer l'ancien controller sinon il reste en fond
	[previousController removeFromParentViewController];
	
	// %TODO Pb conflit avec les boutons de navigation
	switch ([[UIDevice currentDevice] orientation])
	{
		case UIDeviceOrientationLandscapeLeft:
		case UIDeviceOrientationLandscapeRight:
			self.navigationItem.leftBarButtonItem = self.currentController.navigationItem.leftBarButtonItem;
			break;
		default:
			break;
	}
	self.navigationItem.rightBarButtonItem = self.currentController.navigationItem.rightBarButtonItem;
//	self.toolbarItems = self.currentController.toolbarItems;		A tester pour ajout des boutons
	if (self.masterPopoverController)
		[self.masterPopoverController dismissPopoverAnimated:YES];
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
	NSArray *controllers = [svc viewControllers];
	
	barButtonItem.title = [[[controllers objectAtIndex:0] visibleViewController] title];
	[self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
	self.masterPopoverController = pc;
}

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
	[self.navigationItem setLeftBarButtonItem:nil animated:YES];
	self.masterPopoverController = nil;
}
@end
