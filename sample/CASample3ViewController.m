//
//  CASample3ViewController.m
//  CASample3
//
//  Created by François PANARD on 29/08/11.
//  Copyright (c) 2011 FrPa. All rights reserved.
//

#import "EAGLView.h"
#import "CASample3ViewController.h"

@implementation CASample3ViewController
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"OpenGLES Sample";
	[(EAGLView *)self.view startAnimation];
}
@end
