//
//  TableDetailViewController.m
//  navigation
//
//  Created by François PANARD on 02/04/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "TableDetailViewController.h"

@interface TableDetailViewController ()
- (void)configureView;
@end

@implementation TableDetailViewController
@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem)
	{
        _detailItem = newDetailItem;
        [self configureView];
    }
}

- (void)configureView
{
	if (self.detailItem)
	    self.detailDescriptionLabel.text = [self.detailItem description];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self configureView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
	self.detailDescriptionLabel = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
		return nil;
	self.title = NSLocalizedString(@"Detail", @"Detail");
    return self;
}
							
@end
