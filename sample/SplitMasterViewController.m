//
//  SplitMasterViewController.m
//  SplitView
//
//  Created by François PANARD on 23/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "SplitMasterViewController.h"

#import "SplitDetailViewController.h"

@interface SplitMasterViewController ()
{
    NSMutableArray *_chanteurs;
}
@end

@implementation SplitMasterViewController
@synthesize detailViewController = _detailViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
		return nil;
	self.title = NSLocalizedString(@"Chanteurs", @"Chanteurs");
	self.clearsSelectionOnViewWillAppear = NO;
	self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	_chanteurs = [[NSMutableArray alloc] init];
	[_chanteurs addObject:@"Alison Mosshart"];
	[_chanteurs addObject:@"Kate Moss"];
	[_chanteurs addObject:@"Natalie Portman"];
	[_chanteurs addObject:@"Pete Doherty"];
	[_chanteurs sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
	[self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
	[self.tableView.delegate tableView:self.tableView didSelectRowAtIndexPath:self.tableView.indexPathForSelectedRow];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _chanteurs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	NSDate *object = [_chanteurs objectAtIndex:indexPath.row];
	cell.textLabel.text = [object description];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.detailViewController.detailItem = [_chanteurs objectAtIndex:indexPath.row];
}
@end
