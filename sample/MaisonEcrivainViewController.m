//
//  MaisonEcrivainViewController.m
//  MaisonEcrivain
//
//  Created by François PANARD on 10/05/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "MaisonEcrivainViewController.h"
#import "MesAnnotations.h"

@interface MaisonEcrivainViewController ()
{
	NSArray *houses;
}

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation MaisonEcrivainViewController
@synthesize mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	houses = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ecrivains" ofType:@"plist"]];
	double minLatitude = [[houses valueForKeyPath:@"@min.latitude"] doubleValue];
	double maxLatitude = [[houses valueForKeyPath:@"@max.latitude"] doubleValue];
	double minLongitude = [[houses valueForKeyPath:@"@min.longitude"] doubleValue];
	double maxLongitude = [[houses valueForKeyPath:@"@max.longitude"] doubleValue];
	MKCoordinateRegion region;
	
	region.center.latitude = (maxLatitude + minLatitude) / 2.0;
	region.center.longitude = (maxLongitude + minLongitude) / 2.0;
	region.span.latitudeDelta = (maxLatitude - minLatitude) * 1.05;
	region.span.longitudeDelta = (maxLongitude - minLongitude) * 1.05;
	mapView.region = region;
	for (NSDictionary *house in houses)
	{
		MesAnnotations *annotation = [[MesAnnotations alloc] initWithDictionary:house];
		
		[mapView addAnnotation:annotation];
	}
}

- (void)viewDidUnload
{
	houses = nil;
	[self setMapView:nil];
    [super viewDidUnload];
}

/*
 *	MKMapViewDelegate
 *
 */

- (MKAnnotationView *)mapView:(MKMapView *)mkMapView viewForAnnotation:(id<MKAnnotation>)annotation
{
	static NSString *identifier = @"house.identifier";
	
	if (mapView.userLocation == annotation)
		return nil;
	MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
	
	if (!annotationView)
	{
		annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
		annotationView.image = [UIImage imageNamed:@"livre.png"];
		annotationView.canShowCallout = YES;
		annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		annotationView.leftCalloutAccessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stylo.png"]];
	}
	return annotationView;
}

- (void)mapView:(MKMapView *)mkMapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
	NSLog(@"Détails demandés sur le lieu");
}
@end
