//
//  PwdFlipsideViewController.m
//  Password
//
//  Created by François PANARD on 23/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "PwdFlipsideViewController.h"

@interface PwdFlipsideViewController()
- (IBAction)done:(id)sender;
@end

@implementation PwdFlipsideViewController
- (id)init
{
	if (!(self = [super initWithNibName:@"PwdFlipsideViewController" bundle:nil]))
		return nil;
    self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	self.modalPresentationStyle = UIModalPresentationCurrentContext;
   	//self.modalPresentationStyle = UIModalPresentationFullScreen;
   	//self.modalPresentationStyle = UIModalPresentationPageSheet;
   	//self.modalPresentationStyle = UIModalPresentationFormSheet;
	return self;
}

///!!!: Obligatoire sinon se met en paysage

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
	[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
