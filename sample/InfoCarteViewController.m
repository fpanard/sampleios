//
//  InfoCarteViewController.m
//  Altimetre
//
//  Created by François PANARD on 25/05/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "InfoCarteViewController.h"

@interface InfoCarteViewController ()
{
	CoreLocationManager *clController;
}

@property (strong, nonatomic) IBOutlet UILabel *labelView;
@end

@implementation InfoCarteViewController
@synthesize labelView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	clController = [[CoreLocationManager alloc] init];
	clController.delegate = self;
	[clController.locationManager startUpdatingLocation];
}

- (void)viewDidUnload
{
	[self setLabelView:nil];
	clController = nil;
    [super viewDidUnload];
}

#pragma mark CoreLocationControllerDelegate

- (void)locationUpdated:(CLLocation *)location
{
	labelView.text = [NSString stringWithFormat:@"%@\nAltitude : %d",[location description],location.altitude];
}

- (void)locationError:(NSError *)error
{
	labelView.text = [error description];
}
@end
