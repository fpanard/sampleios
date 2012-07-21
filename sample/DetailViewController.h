//
//  DetailViewController.h
//  sample
//
//  Created by François PANARD on 04/09/11.
//  Copyright 2011 FrPa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UISplitViewControllerDelegate>
- (void)loadDetailView:(NSString *)nibName name:(NSString *)name;
- (void)loadDetailController:(UIViewController*)controller name:(NSString *)name;

@property (nonatomic) UIViewController *currentController;
@end
