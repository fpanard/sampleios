//
//  AccelerometreViewController.m
//  Accelerometre
//
//  Created by François PANARD on 14/06/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "AccelerometreViewController.h"

#define SIGNE(x)		(((x) < 0.0f) ? -1.0f : 1.0f)

@interface AccelerometreViewController ()
{
	UIImageView *imageView;
	UIImageView *personnage;
	float accelX,accelY,velociteX,velociteY;
}
@end

@implementation AccelerometreViewController
- (void)loadView
{
	UIImage *image = [UIImage imageNamed:@"personnage.png"];
	
	imageView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	[imageView setImage:[UIImage imageNamed:@"background.tiff"]];
	imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.view = imageView;
	personnage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
	[personnage setImage:image];
	[imageView addSubview:personnage];
	[personnage setCenter:imageView.center];
	accelX = 2.0f;
	accelY = 2.0f;
	velociteX = 0.0f;
	velociteY = 0.0f;
	[[UIAccelerometer sharedAccelerometer] setDelegate:self];
	[NSTimer scheduledTimerWithTimeInterval:0.02f target:self selector:@selector(deplacement) userInfo:nil repeats:YES];
}

- (void)deplacement
{
	CGRect zonePersonnage = personnage.frame;
	
	zonePersonnage.origin.x += velociteX;
	zonePersonnage.origin.y += velociteY;
	if (zonePersonnage.origin.x + zonePersonnage.size.width > self.view.frame.size.width)
		zonePersonnage.origin.x = self.view.frame.size.width - zonePersonnage.size.width;
	if (zonePersonnage.origin.x < 0.0f)
		zonePersonnage.origin.x = 0.0f;
	if (zonePersonnage.origin.y + zonePersonnage.size.height > self.view.frame.size.height)
		zonePersonnage.origin.y = self.view.frame.size.height - zonePersonnage.size.height;
	if (zonePersonnage.origin.y < 0.0f)
		zonePersonnage.origin.y = 0.0f;
	personnage.frame = zonePersonnage;
}

#pragma mark UIAccelerometerDelegate

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
	float xAccel = -acceleration.x;
	float yAccel = acceleration.y;
	float directAccelX = SIGNE(velociteX);
	float nouvDirectX = SIGNE(xAccel);
	float directAccelY = SIGNE(velociteY);
	float nouvDirectY = SIGNE(yAccel);
	
	if (directAccelX == nouvDirectX)
		accelX = (fabs(accelX) + 0.9f) * SIGNE(accelX);
	if (directAccelY == nouvDirectY)
		accelY = (fabs(accelY) + 0.9f) * SIGNE(accelY);
	velociteX = -accelX * xAccel;
	velociteY = -accelY * yAccel;
}
@end
