//
//  ChantOiseauViewController.m
//  ChantOiseau
//
//  Created by François PANARD on 26/04/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "ChantOiseauViewController.h"

@interface ChantOiseauViewController ()
{
	SystemSoundID sound;
	IBOutlet UILabel *titleView;
	IBOutlet UILabel *descriptionView;
	IBOutlet UIImageView *photoView;
}

- (IBAction)play:(id)sender;
@end

@implementation ChantOiseauViewController
- (void)dealloc
{
	if (sound)
		AudioServicesDisposeSystemSoundID(sound);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSURL *url = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"merle" ofType:@"mp3"]];

	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);				// %Vibration iPhone
	AudioServicesCreateSystemSoundID((__bridge CFURLRef)url,&sound);
}

- (void)viewDidUnload
{
	titleView = nil;
	descriptionView = nil;
	photoView = nil;
    [super viewDidUnload];
}

- (IBAction)play:(id)sender 
{
	AudioServicesPlaySystemSound(sound);
}

/*
 *	Pour permettre un layout personnalisé en mode portrait non faisable avec IB
 *
 */

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	if (toInterfaceOrientation == UIInterfaceOrientationPortrait)
	{
		titleView.frame = CGRectMake(20,20,280,21);
		descriptionView.frame = CGRectMake(20,348,280,54);
		photoView.frame = CGRectMake(0,113,320,227);
	}
	else
	{
		titleView.frame = CGRectMake(20,20,203,21);
		descriptionView.frame = CGRectMake(20,49,188,54);
		photoView.frame = CGRectMake(230,0,249,256);
	}
}
@end
