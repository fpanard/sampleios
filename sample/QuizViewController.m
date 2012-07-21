//
//  QuizViewController.m
//  MegaQuiz
//
//  Created by François PANARD on 23/02/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "QuizViewController.h"

@interface QuizViewController ()
- (IBAction)responseChoise:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *responseText;
@end

@implementation QuizViewController
@synthesize responseText;

- (void)viewDidUnload
{
	[self setResponseText:nil];
    [super viewDidUnload];
}

- (IBAction)responseChoise:(id)sender
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
