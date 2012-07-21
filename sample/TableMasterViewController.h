//
//  TableMasterViewController.h
//  navigation
//
//  Created by François PANARD on 02/04/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableDetailViewController;

@interface TableMasterViewController : UITableViewController

@property (strong, nonatomic) TableDetailViewController *detailViewController;

@end
