//
//  ReaderDetailViewController.m
//  iPadRssReader
//
//  Created by François PANARD on 06/04/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "ReaderDetailViewController.h"

@interface ReaderDetailViewController ()

@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (strong, nonatomic) IBOutlet UIWebView *detailContentView;

- (void)configureView;
@end

@implementation ReaderDetailViewController
@synthesize detailItem = _detailItem;
@synthesize masterPopoverController = _masterPopoverController;
@synthesize detailContentView = _detailContentView;

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
}

- (void)configureView
{
	if (self.detailItem)
	{
		NSString *content = [[NSString alloc] initWithFormat:@"<div style='font-family:Verdana;font-size:12px'>%@</div>",[_detailItem objectForKey:@"description"]];

		self.title = [_detailItem objectForKey:@"title"];
		[self.detailContentView loadHTMLString:content baseURL:nil];
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self configureView];
}

- (void)viewDidUnload
{
	[self setDetailContentView:nil];
    [super viewDidUnload];
}

- (id)init
{
    if (!(self = [super initWithNibName:@"ReaderDetailViewController" bundle:nil]))
		return nil;
    return self;
}

#pragma mark - Split view

/*
 *	Attention le delegate n'est pas appelé, c'est celui de controller de base qui est appelé : DetailViewController
 *
 */

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Flux", @"Flux");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}
@end
