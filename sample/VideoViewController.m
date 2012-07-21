//
//  VideoViewController.m
//  Video
//
//  Created by François PANARD on 27/04/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "VideoViewController.h"

@interface VideoViewController ()

@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) MPMoviePlayerController *videoReader;		// Obligatoire et strong avec ARC sinon le player est libéré
@property (strong, nonatomic) IBOutlet UIBarButtonItem *playView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbarView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *stopView;

- (IBAction)play:(id)sender;
- (IBAction)stop:(id)sender;
@end

@implementation VideoViewController
@synthesize playView;
@synthesize toolbarView;
@synthesize stopView;
@synthesize mainView,videoReader;

- (void)viewDidUnload
{
	[self setMainView:nil];
	[self setVideoReader:nil];
	[self setPlayView:nil];
	[self setToolbarView:nil];
	[self setStopView:nil];
    [super viewDidUnload];
}

- (IBAction)play:(id)sender 
{
	//NSURL *videoURL = [[NSBundle mainBundle] URLForResource:@"bunny" withExtension:@"mov"];
	NSURL *videoURL = [[NSBundle mainBundle] URLForResource:@"sequence" withExtension:@"m4v"];
		
	videoReader = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:videoReader];
	[videoReader prepareToPlay];
	[videoReader.view setFrame:mainView.bounds];
	[mainView addSubview:videoReader.view];
	videoReader.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;		// Permet la gestion de la rotation automatique
	[videoReader play];
	[videoReader setFullscreen:YES animated:YES];
	toolbarView.items = [NSArray arrayWithObjects:[toolbarView.items objectAtIndex:0],stopView,[toolbarView.items objectAtIndex:2],nil];
}

- (IBAction)stop:(id)sender 
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:videoReader];
	[videoReader stop];
	[videoReader.view removeFromSuperview];
	[self setVideoReader:nil];
	toolbarView.items = [NSArray arrayWithObjects:[toolbarView.items objectAtIndex:0],playView,[toolbarView.items objectAtIndex:2],nil];
}

- (void)moviePlayerDidFinish:(NSNotification *)notification
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:videoReader];
	[videoReader.view removeFromSuperview];
	[self setVideoReader:nil];
	toolbarView.items = [NSArray arrayWithObjects:[toolbarView.items objectAtIndex:0],playView,[toolbarView.items objectAtIndex:2],nil];
}
@end
