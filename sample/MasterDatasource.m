//
//  MasterDatasource.m
//  sample
//
//  Created by François PANARD on 13/09/11.
//  Copyright 2011 FrPa. All rights reserved.
//

#import "MasterDatasource.h"

@interface MasterDatasource ()
{
	NSDictionary *data;
	NSArray *keys;
}
@end

@implementation MasterDatasource
- (id)initWithDictionary:(NSString *)dictionary
{
	if (!(self = [super init]))
		return nil;
	data = [[NSDictionary alloc] initWithContentsOfFile:dictionary];
	keys = [[data allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
	return self;
}

- (NSDictionary *)objectAtPath:(NSIndexPath *)indexPath
{
	NSString *key = [keys objectAtIndex:[indexPath indexAtPosition:0]];
	
	return [[data objectForKey:key] objectAtIndex:[indexPath indexAtPosition:1]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [data count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSString *key = [keys objectAtIndex:section];
	
	if (key)
		return [[data objectForKey:key] count];
	return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSString *key = [keys objectAtIndex:section];

	if (key)
		return key;
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
	cell.textLabel.text = [[self objectAtPath:indexPath] objectForKey:@"name"];
    return cell;
}
@end
