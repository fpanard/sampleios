//
//  MultiVuesViewController.h
//  MultiVues
//
//  Created by François PANARD on 06/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VueDeuxController;

@interface MultiVuesViewController : UIViewController

- (IBAction)changerVue:(id)sender;

@property (nonatomic,strong) VueDeuxController *vueDeuxController;
@end
