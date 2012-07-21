//
//  InfosViewController.m
//  MultiConvertisseur
//
//  Created by François PANARD on 14/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "InfosViewController.h"

@implementation InfosViewController
- (id)init
{
    if (!(self = [super initWithNibName:@"InfosViewController" bundle:nil]))
		return nil;
	self.title = NSLocalizedString(@"Infos",@"Infos");
	self.tabBarItem.image = [UIImage imageNamed:@"infos"];
    return self;
}

- (IBAction)changeTab:(id)sender
{
	[UIView beginAnimations:@"ChangeView" context:nil];
	[UIView setAnimationDuration:2.0];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
	[[self tabBarController] setSelectedIndex:1];
	[UIView commitAnimations];
}
@end
