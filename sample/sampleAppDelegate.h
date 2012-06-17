//
//  sampleAppDelegate.h
//  sample
//
//  Created by François PANARD on 04/09/11.
//  Copyright 2011 FrPa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sampleAppDelegate : NSObject <UIApplicationDelegate>

@property (strong,nonatomic) UIWindow *window;
@property (strong,nonatomic) UINavigationController *navigationController;
@property (strong,nonatomic) UISplitViewController *splitViewController;
@end
