//
//  sampleAppDelegate.m
//  sample
//
//  Created by François PANARD on 04/09/11.
//  Copyright 2011 FrPa. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "sampleAppDelegate.h"

@interface sampleAppDelegate()
- (void)initPhone;
- (void)initPad;
@end

@implementation sampleAppDelegate
@synthesize window = _window;
@synthesize navigationController = _navigationController;
@synthesize splitViewController = _splitViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
		[self initPhone];
	else
		[self initPad];
	[self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}


- (void)initPhone
{
	MasterViewController *masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterView_iPhone" bundle:nil];
	
	self.navigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
	self.window.rootViewController = self.navigationController;
}

- (void)initPad
{
	MasterViewController *masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterView_iPad" bundle:nil];
	UINavigationController *masterNavigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
	DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailView_iPad" bundle:nil];
	UINavigationController *detailNavigationController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
	
	masterViewController.detailViewController = detailViewController;
	self.splitViewController = [[UISplitViewController alloc] init];
	self.splitViewController.delegate = detailViewController;
	self.splitViewController.viewControllers = [NSArray arrayWithObjects:masterNavigationController, detailNavigationController,nil];
	self.window.rootViewController = self.splitViewController;
}
@end
