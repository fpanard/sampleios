//
//  TableMasterController.m
//  sample
//
//  Created by François PANARD on 15/07/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "TableMasterController.h"
#import "TableMasterViewController.h"

@implementation TableMasterController
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.viewControllers = [NSArray arrayWithObjects:[[TableMasterViewController alloc] initWithNibName:@"TableMasterViewController" bundle:nil],nil];
}
@end
