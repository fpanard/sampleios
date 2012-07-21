//
//  QuizFirstViewController.m
//  MultiQuiz
//
//  Created by François PANARD on 24/02/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "QuizFirstViewController.h"

@implementation QuizFirstViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
		return nil;
	self.title = NSLocalizedString(@"First", @"First");
	self.tabBarItem.image = [UIImage imageNamed:@"first"];
    return self;
}
@end
