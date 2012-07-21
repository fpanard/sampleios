//
//  MultiConvertisseurViewController.m
//  sample
//
//  Created by François PANARD on 13/07/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "MultiConvertisseurViewController.h"
#import "InfosViewController.h"
#import "TempViewController.h"
#import "LongViewController.h"
#import "PoidsViewController.h"

@implementation MultiConvertisseurViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	UIViewController *viewController1 = [[InfosViewController alloc] init];
	UIViewController *viewController2 = [[TempViewController alloc] init];
	UIViewController *viewController3 = [[LongViewController alloc] init];
	UIViewController *viewController4 = [[PoidsViewController alloc] init];
	
	self.viewControllers = [NSArray arrayWithObjects:viewController1,viewController2,viewController3,viewController4,nil];
}
@end
