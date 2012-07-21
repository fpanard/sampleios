//
//  InfoCarte2ViewController.m
//  InfoCarte
//
//  Created by François PANARD on 21/05/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "InfoCarte2ViewController.h"

@interface InfoCarte2ViewController ()
{
	MKMapView *carteView;
	UIButton *lanceGeocodage;
	UIActivityIndicatorView *indicateurActivite;
	CLGeocoder *geocoder;
}
@end

@implementation InfoCarte2ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	carteView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 768, 950)];
	carteView.showsUserLocation = YES;
	carteView.mapType = MKMapTypeHybrid;
	carteView.delegate = self;
	carteView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self.view addSubview:carteView];
	lanceGeocodage = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	lanceGeocodage.frame = CGRectMake(280, 955, 140, 30);
	lanceGeocodage.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
	[lanceGeocodage setTitle:@"Afficher des infos" forState:UIControlStateNormal];
	[lanceGeocodage addTarget:self action:@selector(reverseGeocodePosition:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:lanceGeocodage];
	indicateurActivite = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	indicateurActivite.hidesWhenStopped = YES;
	indicateurActivite.center = CGPointMake(480, 975);
	indicateurActivite.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
	[self.view addSubview:indicateurActivite];
	geocoder = [[CLGeocoder alloc] init];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
	carteView = nil;
	lanceGeocodage = nil;
	indicateurActivite = nil;
	geocoder = nil;
}

- (void)reverseGeocodePosition:(id)sender
{
	[indicateurActivite startAnimating];
	[geocoder reverseGeocodeLocation:carteView.userLocation.location completionHandler:^(NSArray *placemarks, NSError *error)
	{
		[indicateurActivite stopAnimating];
        if (error)
		{
			NSLog(@"Erreur reverseGeocodeLocation %@",error);
            return;
        }
		NSLog(@"Place : %@",placemarks);
		CLPlacemark *placemark = [placemarks objectAtIndex:0];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Informations" 
														message:[NSString stringWithFormat:@"Nom : %@\nPays: %@\nCode postal : %@\nVille : %@\nAdresse : %@\nNuméro de rue : %@\nZone administrative : %@\nCode pays : %@\nSous-zone administrative : %@\n,Lac : %@\n,Ocean : %@\nInterret : %@",
																 placemark.name,
																 placemark.country,
																 placemark.postalCode,
																 placemark.locality,
																 placemark.thoroughfare,
																 placemark.subThoroughfare,
																 placemark.administrativeArea,
																 placemark.ISOcountryCode,
																 placemark.subAdministrativeArea,
																 placemark.inlandWater,
																 placemark.ocean,
																 placemark.areasOfInterest]
													   delegate:self
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
		[alert show];
    }];
}

/*
 *	MKMapViewDelegate
 *
 */

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
	MKCoordinateSpan span = {0.01,0.01};
	
	[indicateurActivite startAnimating];
	[mapView setRegion:MKCoordinateRegionMake(mapView.userLocation.location.coordinate,span) animated:YES];
	[geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *placemarks, NSError *error)
	 {
		 [indicateurActivite stopAnimating];
		 if (error)
		 {
			 NSLog(@"Erreur reverseGeocodeLocation %@",error);
			 return;
		 }
		 NSLog(@"Place : %@",placemarks);
	 }];
}
@end
