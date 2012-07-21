//
//  WebCamViewController.m
//  WebCam
//
//  Created by François PANARD on 11/04/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "WebCamViewController.h"

@interface WebCamViewController ()
@property (strong, nonatomic) IBOutlet UIToolbar *toolbarView;
@property (strong, nonatomic) UIImageView *webView;

- (IBAction)refreshWebcam:(id)sender;
@end

@implementation WebCamViewController
@synthesize toolbarView,webView;

- (IBAction)refreshWebcam:(id)sender
{
	NSURL *url = [NSURL URLWithString:@"http://www.parisrama.com/webcam9.jpg"];
	UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];

	webView.contentMode = UIViewContentModeScaleAspectFill;
	webView.image = image;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSURL *url = [NSURL URLWithString:@"http://www.parisrama.com/webcam9.jpg"];
	UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
	
	webView = [[UIImageView alloc] initWithFrame:self.view.bounds];
	webView.contentMode = UIViewContentModeScaleAspectFill;
	webView.image = image;
	webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self.view insertSubview:webView belowSubview:toolbarView];
}

- (void)viewDidUnload
{
	[self setWebView:nil];
	[self setToolbarView:nil];
    [super viewDidUnload];
}
@end
