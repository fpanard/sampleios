//
//  Roue4ViewController.m
//  Roue4
//
//  Created by François PANARD on 29/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "Roue4ViewController.h"

@interface Roue4ViewController ()

@property (strong,nonatomic) NSDictionary *ouvragesPearson;
@property (strong,nonatomic) NSArray *rayons;
@property (strong,nonatomic) NSArray *ouvrages;
@end

@implementation Roue4ViewController
@synthesize libraryPicker;
@synthesize textView;
@synthesize ouvragesPearson;
@synthesize ouvrages;
@synthesize rayons;

- (void)viewDidLoad
{
    [super viewDidLoad];
	ouvragesPearson = [[NSDictionary alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"ouvrages" withExtension:@"plist"]];
	NSArray *composantes = [ouvragesPearson allKeys];
	NSArray *tri = [composantes sortedArrayUsingSelector:@selector(compare:)];
	rayons = [NSArray arrayWithArray:tri];
	ouvrages = [ouvragesPearson objectForKey:[rayons objectAtIndex:0]];
}

- (void)viewDidUnload
{
	[self setLibraryPicker:nil];
	[self setLibraryPicker:nil];
	[self setTextView:nil];
	ouvrages = nil;
	ouvragesPearson = nil;
	rayons = nil;
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
		case COMPONENT_RAYON:
			return [rayons count];
		case COMPONENT_OUVRAGE:
			return [ouvrages count];
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
		case COMPONENT_RAYON:
			return [rayons objectAtIndex:row];
		case COMPONENT_OUVRAGE:
			return [ouvrages objectAtIndex:row];
	}
	return nil;
}

- (void)pickerView:(UIPickerView *)pickView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	if (component == COMPONENT_RAYON)
	{
		ouvrages = [ouvragesPearson objectForKey:[rayons objectAtIndex: row]];
		[pickView selectRow:0 inComponent:COMPONENT_OUVRAGE animated:YES];
		[pickView reloadComponent:COMPONENT_OUVRAGE];
	}
	textView.text = [[NSString alloc] initWithFormat:@"%@ > %@",[rayons objectAtIndex:[pickView selectedRowInComponent:COMPONENT_RAYON]],[ouvrages objectAtIndex:[pickView selectedRowInComponent:COMPONENT_OUVRAGE]],nil];
}
@end
