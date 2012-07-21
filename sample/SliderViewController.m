//
//  SliderViewController.m
//  Slider
//
//  Created by François PANARD on 26/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "SliderViewController.h"

@implementation SliderViewController
@synthesize sliderView;
@synthesize textView;
@synthesize colorView;
@synthesize scrollView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self sliderChanged:self];
	scrollView.contentSize = self.view.frame.size;
	colorView.backgroundColor = [UIColor redColor];
}

- (void)viewDidUnload
{
	[self setSliderView:nil];
	[self setTextView:nil];
	[self setColorView:nil];
	[self setScrollView:nil];
    [super viewDidUnload];
}

- (IBAction)sliderChanged:(id)sender
{
	NSString *value = [[NSString alloc] initWithFormat:@"%f",sliderView.value];

	textView.text = value;
	colorView.alpha = sliderView.value;
}

- (IBAction)displayValue:(id)sender 
{
	NSString *msg = [[NSString alloc] initWithFormat:@"Vous avez sélectionné la valeur %f",sliderView.value];
	UIAlertView *alerte = [[UIAlertView alloc] initWithTitle:@"Valeur sélectionnée" message:msg delegate:self cancelButtonTitle:@"Je recommence !" otherButtonTitles:nil];
	
	[alerte show];
}

- (IBAction)colorChanged:(id)sender
{
	UISegmentedControl *segmentView = (UISegmentedControl *)sender;
	
	switch (segmentView.selectedSegmentIndex)
	{
		case 0:
			colorView.backgroundColor = [UIColor redColor];
			break;
		case 1:
			colorView.backgroundColor = [UIColor greenColor];
			break;
	}
}
@end
