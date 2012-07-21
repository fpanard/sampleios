//
//  MasterViewController.h
//  sample
//
//  Created by François PANARD on 04/09/11.
//  Copyright 2011 FrPa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterController : UITableViewController<UITableViewDelegate>
{
}

@property (strong,nonatomic) UIViewController *detailViewController;
@end

@interface MasterViewController : MasterController
@end
