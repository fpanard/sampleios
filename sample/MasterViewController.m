//
//  MasterViewController.m
//  sample
//
//  Created by François PANARD on 04/09/11.
//  Copyright 2011 FrPa. All rights reserved.
//

#import "MasterDatasource.h"
#import "DetailViewController.h"
#import "CASample1ViewController.h"
#import "CASample2ViewController.h"
#import "CASample3ViewController.h"
#import "MasterViewController.h"

@implementation MasterController
@synthesize detailViewController = _detailViewController;
@end

@interface MasterViewController()
{
	MasterDatasource *datasource;
}

@property (nonatomic) UIPopoverController *masterPopoverController;
@end

@implementation MasterViewController
@synthesize masterPopoverController = _masterPopoverController;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	datasource = [[MasterDatasource alloc] initWithDictionary:[[NSBundle mainBundle] pathForResource:@"master" ofType:@"plist"]];
    [super viewDidLoad];
	self.title = @"Samples";
	self.tableView.dataSource = datasource;
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
	{
		self.clearsSelectionOnViewWillAppear = NO;
		self.contentSizeForViewInPopover = CGSizeMake(320.0,600.0);
		//[self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
	{
		if (!self.detailViewController)
			self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailView_iPhone" bundle:nil];
		[self.navigationController pushViewController:self.detailViewController animated:YES];
	}
	NSDictionary *sample = [datasource objectAtPath:indexPath];
	NSString *controllerName = [sample objectForKey:@"controller"];
	NSString *viewName = [sample objectForKey:@"view"];
	NSString *masterControllerName = [sample objectForKey:@"mastercontroller"];
	
	if (!viewName)
	{
		if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
			viewName = [sample objectForKey:@"view_iphone"];
		else
			viewName = [sample objectForKey:@"view_ipad"];
	}
	if (!controllerName)
		[(DetailViewController *)self.detailViewController loadDetailView:viewName name:[sample objectForKey:@"name"]];
	else
	if (!viewName)
		[(DetailViewController *)self.detailViewController loadDetailController:[[NSClassFromString(controllerName) alloc] init] name:[sample objectForKey:@"name"]];
	else
	{
		UIViewController *controller = [[NSClassFromString(controllerName) alloc] initWithNibName:viewName bundle:nil];
		
		[(DetailViewController *)self.detailViewController loadDetailController:controller name:[sample objectForKey:@"name"]];
	}
	if (masterControllerName)
	{
		MasterController *masterController = [[NSClassFromString(masterControllerName) alloc] init];
		
		masterController.detailViewController = ((DetailViewController *)self.detailViewController).currentController;
		[self.navigationController pushViewController:masterController animated:YES];
	}
}
@end
