//
//  SimpleView.m
//  CASample1
//
//  Created by François PANARD on 24/08/11.
//  Copyright 2011 FrPa. All rights reserved.
//

#import "BoxView.h"
#import "SimpleView.h"

@interface SimpleView()
- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer;
- (void)handleRotation:(UIRotationGestureRecognizer *)recognizer;
@end

@implementation SimpleView
@synthesize boxView;

- (void)awakeFromNib
{
	CGFloat size = 44.0f;
	CGRect rect = CGRectMake((320.0f - size) / 2.0f,size + 10.0f,size,size);
	UIGestureRecognizer *gesturePinch,*gestureRotate;

	boxView = [[BoxView alloc] initWithFrame:rect];
	boxView.backgroundColor = [UIColor redColor];
	self.backgroundColor = [UIColor blackColor];
	[self addSubview:boxView];
	gesturePinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
	[self addGestureRecognizer:gesturePinch];
	gestureRotate = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
	[self addGestureRecognizer:gestureRotate];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = touches.anyObject;
	
	[UIView beginAnimations:@"center" context:nil];
	self.boxView.center = [touch locationInView:self];
	[UIView commitAnimations];
}

- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer
{
	boxView.transform = CGAffineTransformMakeScale(recognizer.scale,recognizer.scale);
}

- (void)handleRotation:(UIRotationGestureRecognizer *)recognizer
{
	boxView.transform = CGAffineTransformRotate(boxView.transform,recognizer.rotation);
}

- (void)layoutSubviews
{
	CGRect bounds = [boxView convertRect:boxView.bounds toView:self];
	CGRect parentBounds = [self bounds];
	
	if (CGRectGetMinX(bounds) < 0)
		bounds = CGRectOffset(bounds,-CGRectGetMinX(bounds),0);
	if (CGRectGetMinY(bounds) < 0)
		bounds = CGRectOffset(bounds,0,-CGRectGetMinY(bounds));
	if (CGRectGetMaxX(bounds) > parentBounds.size.width)
		bounds = CGRectOffset(bounds,parentBounds.size.width - CGRectGetMaxX(bounds),0);
	if (CGRectGetMaxY(bounds) > parentBounds.size.height)
		bounds = CGRectOffset(bounds,0,parentBounds.size.height - CGRectGetMaxY(bounds));
	if (!CGRectEqualToRect(bounds,[boxView convertRect:boxView.bounds toView:self]))
		boxView.center = CGPointMake(CGRectGetMidX(bounds),CGRectGetMidY(bounds));	
}
@end
