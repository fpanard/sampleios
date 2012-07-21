//
//  ReaderMasterViewController.m
//  iPadRssReader
//
//  Created by François PANARD on 06/04/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "TouchXML.h"
#import "ReaderMasterViewController.h"
#import "ReaderDetailViewController.h"

@interface ReaderMasterViewController ()
{
	NSMutableArray *entries;
}
@end

@implementation ReaderMasterViewController
- (id)init
{
	if (!(self = [super initWithNibName:@"ReaderMasterViewController" bundle:nil]))
		return nil;
	self.title = NSLocalizedString(@"Master", @"Master");
	self.clearsSelectionOnViewWillAppear = NO;
	self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	entries = [[NSMutableArray alloc] init];
	NSURL *url = [NSURL URLWithString:@"http://rss.feedsportal.com/c/32268/f/438243/index.rss"];
	CXMLDocument *xmlDocument = [[CXMLDocument alloc] initWithContentsOfURL:url options:0 error:nil];
	NSArray *feedTitle = [xmlDocument nodesForXPath:@"//channel/title" error:nil];
	
	self.title = [[feedTitle objectAtIndex:0] stringValue];
	NSArray *entriesElement = [xmlDocument nodesForXPath:@"//item" error:nil];
	for (CXMLElement *entry in entriesElement)
	{
		NSMutableDictionary *blogElement = [[NSMutableDictionary alloc] init];
		
		for (int i = 0;i < [entry childCount];i++)
			[blogElement setObject:[[entry childAtIndex:i] stringValue] forKey:[[entry childAtIndex:i] name]];
		[entries addObject:blogElement];
	}
	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
	
	[self.tableView selectRowAtIndexPath:path animated:NO scrollPosition:UITableViewScrollPositionTop];
	[self tableView:self.tableView didSelectRowAtIndexPath:path];
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
	return entries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	cell.textLabel.text = [[entries objectAtIndex:indexPath.row] objectForKey:@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	((ReaderDetailViewController *)self.detailViewController).detailItem = [entries objectAtIndex:indexPath.row];
}
@end
