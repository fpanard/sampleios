//
//  TempViewController.m
//  MultiConvertisseur
//
//  Created by François PANARD on 14/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "TempViewController.h"

@interface TempViewController ()
{
	NSNumberFormatter *numberFormatter;
	BOOL observersRegistered;
}

- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillBeHidden:(NSNotification *)notification;
- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (void)textFieldDidEndEditing:(UITextField *)textField;
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

- (void)makeVisible:(UIView *)view;

@property (weak, nonatomic) IBOutlet UITextField *activeField;
@end

@implementation TempViewController
@synthesize inputFer;
@synthesize inputCent;
@synthesize outputCent;
@synthesize outputFer;
@synthesize scrollView;
@synthesize activeField;

- (id)init
{
    if (!(self = [super initWithNibName:@"TempViewController" bundle:nil]))
		return nil;
	self.title = NSLocalizedString(@"Températures",@"Températures");
	self.tabBarItem.image = [UIImage imageNamed:@"temp"];
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
	if (!observersRegistered)
	{
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
		observersRegistered = YES;
	}
}

- (void)viewDidDisappear:(BOOL)animated
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	observersRegistered = NO;
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
    [self setInputFer:nil];
    [self setInputCent:nil];
    [self setOutputCent:nil];
    [self setOutputFer:nil];
    [self setScrollView:nil];
	[self setScrollView:nil];
    [super viewDidUnload];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
	CGRect keyboardEndFrame = CGRectZero;
	NSTimeInterval animationDuration = 0.0;
	UIEdgeInsets contentInsets;
	
	[[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
	[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
	keyboardEndFrame = [self.view convertRect:keyboardEndFrame fromView:nil];
	contentInsets = UIEdgeInsetsMake(0.0,0.0,keyboardEndFrame.size.height,0.0);
	[UIView animateWithDuration:animationDuration 
					 animations:^{
						 scrollView.contentInset = contentInsets;
						 scrollView.scrollIndicatorInsets = contentInsets;
						 [self makeVisible:activeField];
					 }];
}

- (void)keyboardWillBeHidden:(NSNotification *)notification
{
	UIEdgeInsets contentInsets = UIEdgeInsetsZero;
	NSTimeInterval animationDuration = 0.0;
	[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
	
	[UIView animateWithDuration:animationDuration 
					 animations:^{
						 scrollView.contentInset = contentInsets;
						 scrollView.scrollIndicatorInsets = contentInsets;
					 }];
}

- (void)makeVisible:(UIView *)view
{
	CGRect rect = self.view.frame;
	CGPoint pos = activeField.frame.origin;
	
	rect = UIEdgeInsetsInsetRect(rect,scrollView.contentInset);
	pos.y += 10;
	if (!CGRectContainsPoint(rect,pos))
		[scrollView setContentOffset:CGPointMake(0.0,pos.y - rect.size.height) animated:YES];
}

/*
 *	UITextFieldDelegate
 *
 */

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	activeField = textField;
	[self makeVisible:activeField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	activeField = nil;
}

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

- (IBAction)convertFer2Cent:(id)sender 
{
	float inputValue = [[inputFer text] floatValue];
	float outputValue = (inputValue - 32.0f) * 5.0f / 9.0f;
	
	[outputCent setText:[NSString stringWithFormat:@"%3.2f",outputValue]];
	[inputFer resignFirstResponder];
}

- (IBAction)convertCent2Fer:(id)sender
{
	float inputValue = [[inputCent text] floatValue];
	float outputValue = (inputValue * 1.8f) + 32.0f;
	
	[outputFer setText:[NSString stringWithFormat:@"%3.2f",outputValue]];
	[inputCent resignFirstResponder];
}
@end
