//
//  SplitPopupoverController.m
//  SplitView
//
//  Created by François PANARD on 24/03/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "SplitPopupoverController.h"

@implementation SplitPopupoverController
@synthesize labelView;
@synthesize description = _description;

- (void)viewDidUnload
{
	[self setLabelView:nil];
    [super viewDidUnload];
}

- (void)setDescription:(NSString *)description
{
	labelView.text = description;
}
@end
