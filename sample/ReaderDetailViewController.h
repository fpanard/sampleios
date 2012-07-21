//
//  ReaderDetailViewController.h
//  iPadRssReader
//
//  Created by François PANARD on 06/04/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReaderDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) NSDictionary *detailItem;
@end
