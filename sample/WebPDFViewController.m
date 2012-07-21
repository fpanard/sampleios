//
//  WebPDFViewController.m
//  WebPDF
//
//  Created by François PANARD on 13/04/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "WebPDFViewController.h"

@implementation WebPDFViewController
- (void)loadView
{
	NSURL *url = [NSURL URLWithString:@"http://manuals.info.apple.com/en_US/ipad_user_guide.pdf"];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	UIWebView *webView = [[UIWebView alloc] initWithFrame:self.parentViewController.view.bounds];

	webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[webView setScalesPageToFit:YES];
	[webView loadRequest:request];
	self.view = webView;
}
@end
