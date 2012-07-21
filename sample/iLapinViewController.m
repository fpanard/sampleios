//
//  iLapinViewController.m
//  iLapin
//
//  Created by François PANARD on 16/06/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "iLapinViewController.h"

@interface iLapinViewController ()
{
	NSDate *dateDebut;
	IBOutlet UIImageView *lapinView;
	int lapinSorti;
	IBOutlet UILabel *scoreView;
	int score;
}

- (IBAction)nourrirLapin:(id)sender;
@end

@implementation iLapinViewController

- (id)init
{
	if (!(self = [super init]))
		return nil;
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Le lapin a faim !"
													message:@"Donne à manger au lapin dès qu'il sort de son terrier en cliquant sur la carotte." 
												   delegate:self 
										  cancelButtonTitle:@"On y va !"
										  otherButtonTitles:nil];
	
	[alert show];
	scoreView.text = [[NSString alloc] initWithFormat:@"%d",score];
}

- (void)viewDidUnload
{
	lapinView = nil;
	scoreView = nil;
    [super viewDidUnload];
}

- (IBAction)nourrirLapin:(id)sender
{
	double nbSecondes = (double)[dateDebut timeIntervalSinceNow] * -1000;
	NSString *vitesseReaction;
	
	if (lapinSorti)
	{
		vitesseReaction = [[NSString alloc] initWithFormat:@"Bien joué ! Il se régale ! Ton temps de réaction est de %1.0f millisecondes. Peux-tu t'améliorer ?",nbSecondes];
		score += 10;
		scoreView.text = [[NSString alloc] initWithFormat:@"%d",score];
	}
	else
		vitesseReaction = @"Pas si vite ! Le lapin a peur et n'est pas sorti de son terrier. Ne gâche pas les carottes ainsi !";
	UIAlertView *alerte = [[UIAlertView alloc] initWithTitle:@"Le lapin a faim !"
													 message:vitesseReaction
													delegate:self
										   cancelButtonTitle:@"OK"
										   otherButtonTitles:nil];
	
	[alerte show];
}

- (void)lapinTerrier:(NSTimer *)timer
{
	lapinView.image = [UIImage imageNamed:@"lapinTerrier.png"];
	int delai = ((int)(random() % 7) + 1);
	
	[NSTimer scheduledTimerWithTimeInterval:3.0 + delai target:self selector:@selector(lapinSortiTerrier:) userInfo:nil repeats:NO];
}

- (void)lapinSortiTerrier:(NSTimer *)timer
{
	lapinView.image = [UIImage imageNamed:@"lapinSorti.png"];
	lapinSorti = 1;
	dateDebut = [NSDate date];
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	lapinView.image = [UIImage imageNamed:@"lapinMoitie.png"];
	lapinSorti = 0;
	[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(lapinTerrier:) userInfo:nil repeats:NO];
}
@end
