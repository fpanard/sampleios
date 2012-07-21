//
//  PeintureView.m
//  Peinture
//
//  Created by François PANARD on 02/05/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "PeintureView.h"

@implementation PeintureView

- (id)initWithFrame:(CGRect)frame
{
	if (!(self = [super initWithFrame:frame]))
		return nil;
    return self;
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef contexte = UIGraphicsGetCurrentContext();
	
	CGContextSetLineWidth(contexte,4.0);
	CGContextSetStrokeColorWithColor(contexte,[UIColor blueColor].CGColor);
	CGContextMoveToPoint(contexte,300,300);
	CGContextAddLineToPoint(contexte,50,50);
	CGContextStrokePath(contexte);
}
@end
