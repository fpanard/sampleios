//
//  MasterViewController.h
//  sample
//
//  Created by François PANARD on 04/09/11.
//  Copyright 2011 FrPa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;
@class MasterDatasource;

@interface MasterViewController : UITableViewController<UITableViewDelegate>
{
	IBOutlet MasterDatasource *masterDatasource;
}

@property (strong,nonatomic) DetailViewController *detailViewController;
@end
