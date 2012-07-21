//
//  MesAnnotations.m
//  MaisonEcrivain
//
//  Created by François PANARD on 14/05/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import "MesAnnotations.h"

@implementation MesAnnotations
@synthesize coordinate,title,subtitle;

- (id)initWithDictionary:(NSDictionary *)dict
{
	if (!(self = [super init]))
		return nil;
	coordinate.latitude = [[dict objectForKey:@"latitude"] doubleValue];
	coordinate.longitude = [[dict objectForKey:@"longitude"] doubleValue];
	title = [dict objectForKey:@"nom"];
	subtitle = [dict objectForKey:@"adresse"];
	return self;
}
@end
