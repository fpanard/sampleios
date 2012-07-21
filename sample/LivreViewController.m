//
//  LivreViewController.m
//  Table
//
//  Created by François PANARD on 02/04/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "LivreViewController.h"

@interface LivreViewController ()

@property (strong,nonatomic) NSArray *livres;
@property (strong,nonatomic) NSString *rayon;
@end

@implementation LivreViewController
@synthesize livres,rayon;

- (id)initWithLivre:(NSArray *)livresArray rayon:(NSString *)rayonName
{
    if (!(self = [super initWithNibName:@"LivreViewController" bundle:nil]))
		return nil;
	livres = livresArray;
	rayon = rayonName;
	self.title = [[NSString alloc] initWithFormat:@"Rayon : %@",rayon];
    return self;
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
	
	if (!cell)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellule];
	cell.textLabel.text = [livres objectAtIndex:[indexPath row]];
	return cell;
}

/*
 *	UITableViewDelegate
 *
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *msg = [[NSString alloc] initWithFormat:@"Vous avez choisi le livre %@",[livres objectAtIndex:[indexPath row]]];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Choix d'un livre" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	
	[alert show];
}
@end
