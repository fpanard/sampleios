//
//  ChoiceViewController.m
//  ChoixAction
//
//  Created by François PANARD on 30/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "ChoiceViewController.h"

@interface ChoiceViewController ()

@end

@implementation ChoiceViewController
@synthesize labelView;
@synthesize colorView;

- (void)viewDidUnload
{
	[self setLabelView:nil];
	[self setColorView:nil];
    [super viewDidUnload];
}

- (IBAction)chooseLink:(id)sender
{
	UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Choix de l'action" 
														delegate:self 
											   cancelButtonTitle:@"Annuler" 
										  destructiveButtonTitle:nil
											   otherButtonTitles:@"YouTube",@"Texte",@"Couleur", nil];
	
	[action showInView:self.view];
	//[action showFromRect:colorView.frame inView:self.view animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex)
	{
		case 0:
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.youtube.com"]];
			break;
		case 1:
			labelView.text = @"Vous avez cliqué sur la seconde option";
			break;
		case 2:
			colorView.backgroundColor = [UIColor greenColor];
			break;
	}
}
@end
