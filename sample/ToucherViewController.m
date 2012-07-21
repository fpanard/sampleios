//
//  ToucherViewController.m
//  Toucher
//
//  Created by François PANARD on 07/06/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "ToucherViewController.h"

@interface ToucherViewController ()

@property (strong, nonatomic) IBOutlet UILabel *msgView;
@property (strong, nonatomic) IBOutlet UILabel *coordView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ToucherViewController
@synthesize msgView;
@synthesize coordView;
@synthesize imageView;

- (void)viewDidUnload
{
	[self setMsgView:nil];
	[self setCoordView:nil];
	[self setImageView:nil];
    [super viewDidUnload];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	msgView.text = @"Début du toucher";
	UITouch *touch = [[event allTouches] anyObject];
	CGPoint location = [touch locationInView:self.view];
	coordView.text = [[NSString alloc] initWithFormat:@"Coordonnées : %.0f %.0f",location.x,location.y];
	NSUInteger pressCount = [[touches anyObject] tapCount];
	switch (pressCount)
	{
		case 1:
			self.view.backgroundColor = [UIColor grayColor];
			break;
		case 2:
			self.view.backgroundColor = [UIColor blackColor];
			break;
		case 3:
			self.view.backgroundColor = [UIColor purpleColor];
			break;
		case 4:
			self.view.backgroundColor = [UIColor whiteColor];
			break;
	}
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	msgView.text = @"Annulation du toucher";
	self.view.backgroundColor = [UIColor redColor];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	msgView.text = @"Arrêt du toucher";
	self.view.backgroundColor = [UIColor blueColor];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	msgView.text = @"Déplacement détecté";
	UITouch *touch = [[event allTouches] anyObject];
	CGPoint location = [touch locationInView:self.view];
	coordView.text = [[NSString alloc] initWithFormat:@"Coordonnées : %.0f, %.0f",location.x,location.y];
	if (CGRectContainsPoint(imageView.frame,location))
		imageView.center = location;
	self.view.backgroundColor = [UIColor greenColor];
}
@end
