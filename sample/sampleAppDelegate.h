//
//  sampleAppDelegate.h
//  sample
//
//  Created by François PANARD on 04/09/11.
//  Copyright 2011 FrPa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sampleAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain) UISplitViewController *splitViewController;
@end
