//
//  MasterViewController.m
//  sample
//
//  Created by François PANARD on 04/09/11.
//  Copyright 2011 FrPa. All rights reserved.
//

#import "DetailViewController.h"
#import "CASample1ViewController.h"
#import "CASample2ViewController.h"
#import "CASample3ViewController.h"
#import "MasterViewController.h"

@interface MasterViewController()
@property (retain,nonatomic) UIPopoverController *masterPopoverController;
@end

@implementation MasterViewController
@synthesize detailViewController = _detailViewController;
@synthesize masterPopoverController = _masterPopoverController;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"Samples";
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
	switch ([indexPath indexAtPosition:0])
	{
		case 0:
			switch ([indexPath indexAtPosition:1])
			{
				case 0:
				{
					UIViewController *controller = [[CASample1ViewController alloc] initWithNibName:@"CASample1View" bundle:nil];
			
					[self.detailViewController loadDetailController:controller];
					[controller release];
					break;
				}
				case 1:
				{
					UIViewController *controller = [[CASample2ViewController alloc] initWithNibName:@"CASample2View" bundle:nil];
			
					[self.detailViewController loadDetailController:controller];
					[controller release];
					break;
				}
				case 2:
				{
					UIViewController *controller = [[CASample3ViewController alloc] initWithNibName:@"CASample3View" bundle:nil];
			
					[self.detailViewController loadDetailController:controller];
					[controller release];
					break;
				}
			}
			break;
		case 1:
			switch ([indexPath indexAtPosition:1])
			{
				case 0:
					if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
						[self.detailViewController loadDetailView:@"ButtonGallery1View_iPhone"];
					else
						[self.detailViewController loadDetailView:@"ButtonGallery1View_iPad"];
					break;
			}
			break;
		case 2:
			switch ([indexPath indexAtPosition:1])
			{
				case 0:
					[self.detailViewController loadDetailView:@"DetailView1"];
					break;
			}
			break;
	}
}
@end
