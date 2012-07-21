//
//  MultiViewController.m
//  sample
//
//  Created by François PANARD on 13/07/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "MultiViewController.h"
#import "MultiVuesViewController.h"

@implementation MultiViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.viewControllers = [NSArray arrayWithObjects:[[MultiVuesViewController alloc] initWithNibName:@"MultiVuesViewController" bundle:nil],nil];
}
@end
