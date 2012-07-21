//
//  TableViewController.m
//  Table
//
//  Created by François PANARD on 30/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "LivreViewController.h"
#import "TableViewController.h"

@interface TableViewController ()

@property (strong,nonatomic) NSArray *livres;
@property (strong,nonatomic) NSDictionary *library;
@end

@implementation TableViewController
@synthesize livres,library;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if (!(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
		return nil;
	self.title = @"Rayons";
	return self;
}

- (void)viewDidLoad
{
	library = [[NSDictionary alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"ouvrages" withExtension:@"plist"]];
	livres = [[library allKeys] sortedArrayUsingSelector:@selector(compare:)];
    [super viewDidLoad];
}

- (void)viewDidUnload
{
	livres = nil;
	library = nil;
    [super viewDidUnload];
}

/*
 *	UITableViewDataSource
 *
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [livres count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellule = @"Cellule";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellule];
	NSString *key = [livres objectAtIndex:[indexPath row]];
	
	if (!cell)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellule];
	cell.textLabel.text = key;
	cell.imageView.image = [UIImage imageNamed:@"livre-table.png"];
	if ([[library objectForKey:key] count])
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}

/*
 *	UITableViewDelegate
 *
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *rayon = [livres objectAtIndex:[indexPath row]];
	LivreViewController *livreController = [[LivreViewController alloc] initWithLivre:[library objectForKey:rayon] rayon:rayon];

	[self.navigationController pushViewController:livreController animated:YES];
}
@end
