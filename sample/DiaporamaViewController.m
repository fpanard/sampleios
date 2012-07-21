//
//  DiaporamaViewController.m
//  Diaporama
//
//  Created by François PANARD on 07/06/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "DiaporamaView.h"
#import "DiaporamaViewController.h"

@interface DiaporamaViewController ()

@end

@implementation DiaporamaViewController
- (void)loadView
{
	NSArray *images = [NSArray arrayWithObjects:
					   [UIImage imageNamed:@"diaporama-01.jpg"],
					   [UIImage imageNamed:@"diaporama-02.jpg"],
					   [UIImage imageNamed:@"diaporama-03.jpg"],
					   [UIImage imageNamed:@"diaporama-04.jpg"],
					   [UIImage imageNamed:@"diaporama-05.jpg"],
					   [UIImage imageNamed:@"diaporama-06.jpg"],
					   nil];
	self.view = [[DiaporamaView alloc] initWithImages:images];
}
@end
