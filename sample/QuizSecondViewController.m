//
//  QuizSecondViewController.m
//  MultiQuiz
//
//  Created by François PANARD on 24/02/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "QuizSecondViewController.h"

@implementation QuizSecondViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
		return nil;
	self.title = NSLocalizedString(@"Second", @"Second");
	self.tabBarItem.image = [UIImage imageNamed:@"second"];
    return self;
}
@end
