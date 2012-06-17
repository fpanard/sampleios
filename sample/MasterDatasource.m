//
//  MasterDatasource.m
//  sample
//
//  Created by François PANARD on 13/09/11.
//  Copyright 2011 FrPa. All rights reserved.
//

#import "MasterDatasource.h"

@implementation MasterDatasource
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	switch (section)
	{
		case 0:
			return 3;
		case 1:
			return 1;
		case 2:
			return 1;
	}
	return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	switch (section)
	{
		case 0:
			return @"Core Animation";
		case 1:
			return @"Boutons";
		case 2:
			return @"Divers";
	}
	return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	switch ([indexPath indexAtPosition:0])
	{
		case 0:
			switch ([indexPath indexAtPosition:1])
			{
				case 0:
					cell.textLabel.text = @"CASample 1";
					break;
				case 1:
					cell.textLabel.text = @"CASample 2";
					break;
				case 2:
					cell.textLabel.text = @"CASample 3";
					break;
			}
			break;
		case 1:
			cell.textLabel.text = @"Gallery 1";
			break;
		case 2:
			cell.textLabel.text = @"Vue quelconque";
			break;
	}
    return cell;
}
@end
