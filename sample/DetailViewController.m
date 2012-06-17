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
@property (nonatomic) UIViewController *currentController;
@end

@implementation DetailViewController
@synthesize masterPopoverController = _masterPopoverController;
@synthesize currentController = _currentController;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)loadDetailView:(NSString *)nibName
{
	UIViewController *controller = [[UIViewController alloc] initWithNibName:nibName bundle:nil];
	
	[self loadDetailController:controller];
	self.title = nibName;
}

- (void)loadDetailController:(UIViewController*)controller
{
	self.currentController = controller;
	[self.view addSubview:self.currentController.view];
	self.currentController.view.frame = self.view.frame;
	self.title = self.currentController.title;
	
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

- (void)viewDidLoad
{
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

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
	barButtonItem.title = [[[svc viewControllers] objectAtIndex:0] title];
	[self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
	self.masterPopoverController = pc;
}

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
	[self.navigationItem setLeftBarButtonItem:nil animated:YES];
	self.masterPopoverController = nil;
}
@end
