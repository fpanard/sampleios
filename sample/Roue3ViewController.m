//
//  Roue3ViewController.m
//  Roue3
//
//  Created by François PANARD on 28/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "Roue3ViewController.h"

@interface Roue3ViewController ()
@property (strong,nonatomic) NSArray *villesArray;
@property (strong,nonatomic) NSArray *servicesArray;
@end

@implementation Roue3ViewController
@synthesize pickerView;
@synthesize textView;
@synthesize villesArray;
@synthesize servicesArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
	villesArray = [[NSArray alloc] initWithObjects:@"Paris",@"Marseille",@"Lyon",@"Bordeaux",@"Lille",nil];
	servicesArray = [[NSArray alloc] initWithObjects:@"La météo",@"Les infos",@"La circulation",@"Les loisirs",@"Les écoles",nil];
}

- (void)viewDidUnload
{
	[self setPickerView:nil];
	[self setTextView:nil];
	villesArray = nil;
	servicesArray = nil;
    [super viewDidUnload];
}

/*
 *	UIPickerViewDataSource
 *
 */

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	switch (component)
	{
		case COMPONENT_VILLES:
			return [villesArray count];
		case COMPONENT_SERVICES:
			return [servicesArray count];
	}
	return 0;
}

/*
 *	UIPickerViewDelegate
 *
 */

- (NSString *)pickerView:(UIPickerView *)pickView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	switch (component)
	{
		case COMPONENT_VILLES:
			return [villesArray objectAtIndex:row];
		case COMPONENT_SERVICES:
			return [servicesArray objectAtIndex:row];
	}
	return nil;
}

- (void)pickerView:(UIPickerView *)pickView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	NSString *ville = [villesArray objectAtIndex:[pickView selectedRowInComponent:COMPONENT_VILLES]];
	NSString *service = [servicesArray objectAtIndex:[pickView selectedRowInComponent:COMPONENT_SERVICES]];
	
	textView.text = [[NSString alloc] initWithFormat:@"%@ à %@ ? C'est parti !",service,ville];
}
@end
