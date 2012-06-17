//
//  BoxView.m
//  CASample1
//
//  Created by François PANARD on 24/08/11.
//  Copyright 2011 FrPa. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "BoxView.h"

@implementation BoxView
- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event
{
	id<CAAction> animation = nil;
	
	if ([event isEqualToString:@"position"])
	{
		animation = [CABasicAnimation animation];
		((CABasicAnimation *)animation).duration = 1.0f;
	}
	else
		animation = [super actionForLayer:layer forKey:event];
	return animation;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = touches.anyObject;
	CGPoint newCenter = [touch locationInView:self.superview];

	[UIView beginAnimations:@"center" context:nil];
	self.center = newCenter;
	[UIView commitAnimations];
}
@end
