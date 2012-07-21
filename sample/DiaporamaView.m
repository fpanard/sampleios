//
//  DiaporamaView.m
//  Diaporama
//
//  Created by François PANARD on 07/06/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "DiaporamaView.h"

@implementation DiaporamaView
- (id)initWithImages:(NSArray *)inImages
{
	if (!(self = [super initWithFrame:CGRectZero]))
		return nil;
	images = inImages;
	NSUInteger imageCount = [inImages count];
	currentImage = 0;
	if (imageCount > 0)
	{
		currentImageView = [self createImageView:currentImage];
		[self addSubview:currentImageView];
		currentImageView.frame = self.frame;
		if (imageCount > 1)
		{
			// TODO: Il y a un problème au premier touchesBegan, l'image n'est à la bonne place
			
			rightImageView = [self createImageView:currentImage + 1];
			rightImageView.hidden = YES;
			[self addSubview:rightImageView];
		}
	}
	self.opaque = YES;
	self.backgroundColor = [UIColor blackColor];
	self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	return self;
}

- (UIImageView *)createImageView:(NSUInteger)index
{
	if (index >= [images count])
		return nil;
	UIImageView *imageView = [[UIImageView alloc] initWithImage:[images objectAtIndex:index]];
	imageView.opaque = YES;
	imageView.userInteractionEnabled = NO;
	imageView.backgroundColor = [UIColor blackColor];
	imageView.contentMode = UIViewContentModeScaleAspectFit;
	imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	return imageView;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if ([touches count] != 1)
		return;
	debutTransition = [[touches anyObject] locationInView:self].x;
	transition = YES;
	leftImageView.hidden = NO;
	currentImageView.hidden = NO;
	rightImageView.hidden = NO;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (!transition || [touches count] != 1)
		return;
	CGFloat distance = [[touches anyObject] locationInView:self].x - debutTransition;
	CGSize tailleVue = self.frame.size;
	
	leftImageView.frame = CGRectMake(distance - tailleVue.width, 0.0f, tailleVue.width, tailleVue.height);
	currentImageView.frame = CGRectMake(distance, 0.0f, tailleVue.width, tailleVue.height);
	rightImageView.frame = CGRectMake(distance + tailleVue.width, 0.0f, tailleVue.width, tailleVue.height);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (!transition)
		return;
	CGSize taillVue = self.frame.size;
	NSUInteger imageCount = [images count];
	CGFloat distance = [[touches anyObject] locationInView:self].x - debutTransition;
	
	if (currentImage > 0 && distance > 100.0f)
	{
		[rightImageView removeFromSuperview];
		rightImageView = currentImageView;
		currentImageView = leftImageView;
		currentImage--;
		if (currentImage > 0)
		{
			leftImageView = [self createImageView:currentImage - 1];
			leftImageView.hidden = YES;
			[self addSubview:leftImageView];
		}
		else
			leftImageView = nil;
	}
	else
		if (currentImage < imageCount - 1 && distance < -100.0f)
		{
			[leftImageView removeFromSuperview];
			leftImageView = currentImageView;
			currentImageView = rightImageView;
			currentImage++;
			if (currentImage < imageCount - 1)
			{
				rightImageView = [self createImageView:currentImage + 1];
				rightImageView.hidden = YES;
				[self addSubview:rightImageView];
			}
			else
				rightImageView = nil;
		}
	[UIView beginAnimations:@"transition" context:NULL];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:0.3f];
	leftImageView.frame = CGRectMake(-taillVue.width, 0.0f, taillVue.width, taillVue.height);
	currentImageView.frame = CGRectMake(0.0f, 0.0f, taillVue.width, taillVue.height);
	rightImageView.frame = CGRectMake(taillVue.width, 0.0f, taillVue.width, taillVue.height);
	[UIView commitAnimations];
	transition = NO;
}
@end
