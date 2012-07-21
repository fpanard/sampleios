//
//  SplitMasterViewController.h
//  SplitView
//
//  Created by François PANARD on 23/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SplitDetailViewController;

@interface SplitMasterViewController : UITableViewController

@property (strong, nonatomic) SplitDetailViewController *detailViewController;
@end
