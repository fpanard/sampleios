//
//  VueDeuxController.h
//  MultiVues
//
//  Created by François PANARD on 06/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VueDeuxController : UIViewController

- (id)initWithRootController:(UIViewController *)controller;
- (IBAction)changerVue:(id)sender;

@property (readonly) UIViewController *rootController;
@end
