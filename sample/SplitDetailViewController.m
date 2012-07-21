//
//  SplitDetailViewController.m
//  SplitView
//
//  Created by François PANARD on 23/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "SplitPopupoverController.h"
#import "SplitDetailViewController.h"

@interface SplitDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (strong, nonatomic) UIPopoverController *descPopoverController;

- (void)configureView;
@end

@implementation SplitDetailViewController
@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize imageView = _imageView;
@synthesize buttonPopover = _buttonPopover;
@synthesize masterPopoverController = _masterPopoverController;
@synthesize descPopoverController = _descPopoverController;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem)
	{
        _detailItem = newDetailItem;
        [self configureView];
    }
    if (self.masterPopoverController)
        [self.masterPopoverController dismissPopoverAnimated:YES];
	if (self.descPopoverController)
		[self.descPopoverController dismissPopoverAnimated:YES];
}

- (void)configureView
{
	if (self.detailItem)
	{
	    self.detailDescriptionLabel.text = [self.detailItem description];
		_imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",[_detailItem description]]];
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self configureView];
}

- (void)viewDidUnload
{
    [self setImageView:nil];
	[self setButtonPopover:nil];
    [super viewDidUnload];
	self.detailDescriptionLabel = nil;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	if (self.descPopoverController)
		[self.descPopoverController dismissPopoverAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}
							
#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Chanteurs", @"Chanteurs");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (IBAction)actionButtonPopover:(id)sender
{
	SplitPopupoverController *popoverContent = [[SplitPopupoverController alloc] initWithNibName:@"SplitPopupoverController" bundle:nil];
	
	popoverContent.contentSizeForViewInPopover = popoverContent.view.frame.size;
	self.descPopoverController = [[UIPopoverController alloc] initWithContentViewController:popoverContent];
	popoverContent.description = [_detailItem description];
	[self.descPopoverController presentPopoverFromRect:_buttonPopover.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
@end
