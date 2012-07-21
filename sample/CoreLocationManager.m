//
//  CoreLocationManager.m
//  Altimetre
//
//  Created by François PANARD on 25/05/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "CoreLocationManager.h"

/*
 *	MARK: CLLocationManagerDelegate
 *	TODO: Test
 *	FIXME: Test1
 *	???: Test2
 *	!!!: Test3
 */


@implementation CoreLocationManager
@synthesize locationManager,delegate;

- (id)init
{
	if (!(self = [super init]))
		return nil;
	locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	return self;
}

#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	[delegate locationUpdated:newLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	[delegate locationError:error];
}
@end
