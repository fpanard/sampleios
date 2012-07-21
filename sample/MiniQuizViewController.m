//
//  MiniQuizViewController.m
//  Quiz
//
//  Created by François PANARD on 22/02/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "MiniQuizViewController.h"

@interface MiniQuizViewController ()

-(IBAction)responseChoice:(id)sender;

@property (weak,nonatomic) UILabel *responseText;
@end

@implementation MiniQuizViewController
@synthesize responseText;

- (void)responseChoice:(id)sender
{
	NSString *response = [sender titleForState:UIControlStateNormal];

	if ([response isEqualToString:@"1928"])
	{
		NSString *newStatus = [NSString stringWithFormat:@"Vous avez trouvé la bonne réponse : %@.",response];
		
		responseText.text = newStatus;
	}
	else
	{
		NSString *newStatus = [NSString stringWithFormat:@"Vous avez choisi la réponse : %@.",response];
		
		responseText.text = newStatus;
	}
}
@end
