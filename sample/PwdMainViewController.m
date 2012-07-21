//
//  PwdMainViewController.m
//  Password
//
//  Created by François PANARD on 23/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "PwdMainViewController.h"
#import "PwdFlipsideViewController.h"

@interface PwdMainViewController ()
{
	BOOL observersRegistered;
}

- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillBeHidden:(NSNotification *)notification;
- (void)makeVisible:(UIView *)view;

@property (weak, nonatomic) IBOutlet UITextField *activeField;
@end

@implementation PwdMainViewController
@synthesize passwordLength;
@synthesize useLowercase;
@synthesize useUppercase;
@synthesize useNumber;
@synthesize usePunctuation;
@synthesize generateButton;
@synthesize passwordResult;
@synthesize scrollView;
@synthesize activeField;

- (id)init
{
	if (!(self = [super initWithNibName:@"PwdMainViewController" bundle:nil]))
		return nil;
	srandom(time(NULL));
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

- (void)viewDidUnload
{
	[self setPasswordLength:nil];
	[self setUseLowercase:nil];
	[self setUseUppercase:nil];
	[self setUseNumber:nil];
	[self setUsePunctuation:nil];
	[self setGenerateButton:nil];
	[self setPasswordResult:nil];
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

/*
	// Cas du déplacement de toute la vue

	CGRect frame = self.view.frame;
	frame.origin.y -= keyboardOverlap;
	[UIView animateWithDuration:animationDuration animations:^{self.view.frame = frame;}];
*/
}

- (void)keyboardWillBeHidden:(NSNotification *)notification
{
/*
	// Cas du déplacement de toute la vue
 
	NSTimeInterval animationDuration = 0.0;
	
	[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
	CGRect frame = self.view.frame;
	frame.origin.y -= -keyboardOverlap;
	[UIView animateWithDuration:animationDuration animations:^{self.view.frame = frame;}];
	keyboardOverlap = 0.0;
*/
	
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
	pos.y += 10 + activeField.frame.size.height;
	if (!CGRectContainsPoint(rect,pos))
		[scrollView setContentOffset:CGPointMake(0.0,pos.y - rect.size.height) animated:YES];
}

#pragma mark - Flipside View

- (IBAction)showInfo:(id)sender
{    
    PwdFlipsideViewController *controller = [[PwdFlipsideViewController alloc] init];

	[self presentViewController:controller animated:YES completion:nil];
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	for (long i = 0;i < [string length];i++)
		if (![[NSCharacterSet decimalDigitCharacterSet] characterIsMember:[string characterAtIndex:i]])
			return NO;
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	return YES;
}

- (IBAction)generatePassword:(id)sender
{
	NSInteger pwdLength = [passwordLength.text intValue];

	if (!pwdLength)
	{
		[passwordLength becomeFirstResponder];
		return;
	}
	[activeField resignFirstResponder];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1];
	[passwordResult setAlpha:0.0];
	[UIView commitAnimations];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1];
	[passwordResult setAlpha:1.0];
	[UIView commitAnimations];
	
	BOOL useLower = useLowercase.on;
	BOOL useUpper = useUppercase.on;
	BOOL useNum = useNumber.on;
	BOOL usePunc = usePunctuation.on;
	NSString *password = @"";
	NSString *dictLower = @"abcdefghijklmnopqrstuvwxyz";
	NSString *dictUpper = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	NSString *dictNumber = @"0123456789";
	NSString *dictPunct = @"!?#%^&*()";
	
	if (!useLower && !useUpper && !useNum && !usePunc)
	{
		UIAlertView *alerte = [[UIAlertView alloc] initWithTitle:@"Aucune règle" message:@"Sélectionnez au moins l'un des critères à l'aide des interrupteurs" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		[alerte show];
		return;
	}
	NSString *dictPassword = @"";
	
	if (useLower)
		dictPassword = [NSString stringWithFormat:@"%@%@",dictPassword,dictLower];
	if (useUpper)
		dictPassword = [NSString stringWithFormat:@"%@%@",dictPassword,dictUpper];
	if (useNum)
		dictPassword = [NSString stringWithFormat:@"%@%@",dictPassword,dictNumber];
	if (usePunc)
		dictPassword = [NSString stringWithFormat:@"%@%@",dictPassword,dictPunct];
	for (NSInteger i = 0;i < pwdLength;i++)
	{
		int index = (random() % [dictPassword length]);
		
		password = [NSString stringWithFormat:@"%@%@",password,[dictPassword substringWithRange:NSMakeRange(index,1)]];
	}
	passwordResult.text = password;
	[UIPasteboard generalPasteboard].string = password;
}
@end
