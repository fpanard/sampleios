//
//  Roue2ViewController.m
//  Roue02
//
//  Created by François PANARD on 28/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "Roue2ViewController.h"

@interface Roue2ViewController ()

@property (strong,nonatomic) NSArray *libraryData;
@end

@implementation Roue2ViewController
@synthesize pickerView;
@synthesize textView;
@synthesize libraryData;

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.libraryData = [[NSArray alloc] initWithObjects:@"Economie",@"Sciences",@"Histoire",@"Apprentissage",@"Classe prépas",@"Informatique",@"Multimédia",@"Vie pratique",nil];
}

- (void)viewDidUnload
{
	[self setPickerView:nil];
	[self setTextView:nil];
	self.libraryData = nil;
    [super viewDidUnload];
}

/*
 *	UIPickerViewDataSource
 *
 */

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [libraryData count];
}

/*
 *	UIPickerViewDelegate
 *
 */

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [libraryData objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	textView.text = [libraryData objectAtIndex:row];
}
@end
