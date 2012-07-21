//
//  Roue1ViewController.m
//  Roue01
//
//  Created by François PANARD on 27/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "Roue1ViewController.h"

@implementation Roue1ViewController
@synthesize datePicker;
@synthesize textView;

- (void)viewDidUnload
{
	[self setDatePicker:nil];
	[self setTextView:nil];
    [super viewDidUnload];
}

- (IBAction)displayDate:(id)sender
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	
	[formatter setDateStyle:NSDateFormatterShortStyle];
	[formatter setTimeStyle:NSDateFormatterShortStyle];
	textView.text = [formatter stringFromDate:datePicker.date];
}
@end
