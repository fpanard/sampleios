//
//  CoreLocationManager.h
//  Altimetre
//
//  Created by François PANARD on 25/05/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol CoreLocationControllerDelegate
@required
- (void)locationUpdated:(CLLocation *)location;
- (void)locationError:(NSError *)error;
@end

@interface CoreLocationManager : NSObject<CLLocationManagerDelegate>
{
	CLLocationManager *locationManager;
	id<CoreLocationControllerDelegate> delegate;
}

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) id<CoreLocationControllerDelegate> delegate;
@end
