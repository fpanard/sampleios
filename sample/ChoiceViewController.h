//
//  ChoiceViewController.h
//  ChoixAction
//
//  Created by François PANARD on 30/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoiceViewController : UIViewController<UIActionSheetDelegate>
@property (strong, nonatomic) IBOutlet UILabel *labelView;
@property (strong, nonatomic) IBOutlet UIView *colorView;

- (IBAction)chooseLink:(id)sender;
@end
