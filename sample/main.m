//
//  main.m
//  sample
//
//  Created by François PANARD on 04/09/11.
//  Copyright 2011 FrPa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sampleAppDelegate.h"

int main(int argc, char *argv[])
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	int retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([sampleAppDelegate class]));
	[pool release];
	return retVal;
}
