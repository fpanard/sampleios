//
//  LongViewController.m
//  MultiConvertisseur
//
//  Created by François PANARD on 14/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "LongViewController.h"

@interface LongViewController ()
{
	NSNumberFormatter *numberFormatter;	
}
@end

@implementation LongViewController
@synthesize inputValue;
@synthesize outputValue;

- (id)init
{
    if (!(self = [super initWithNibName:@"LongViewController" bundle:nil]))
		return nil;
	self.title = NSLocalizedString(@"Longueurs",@"Longueurs");
	self.tabBarItem.image = [UIImage imageNamed:@"longueurs"];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[numberFormatter setPartialStringValidationEnabled:YES];
}

- (void)viewDidUnload
{
	numberFormatter = nil;
    [self setInputValue:nil];
    [self setOutputValue:nil];
    [super viewDidUnload];
}

- (IBAction)convert:(id)sender
{
	float value = [[inputValue text] floatValue];
	float convValue = value / 2.4f;
	
	[outputValue setText:[NSString stringWithFormat:@"%3.2f",convValue]];
	[inputValue resignFirstResponder];
}

/*
 *	UITextFieldDelegate
 *
 */

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	NSString *value = [textField.text stringByReplacingCharactersInRange:range withString:string];
	id objValue;
	
	if ([numberFormatter getObjectValue:&objValue forString:value errorDescription:nil])
		return YES;
	return NO;
}
@end
