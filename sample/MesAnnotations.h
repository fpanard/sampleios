//
//  MesAnnotations.h
//  MaisonEcrivain
//
//  Created by François PANARD on 14/05/12.
//  Copyright (c) 2012 FrPa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MesAnnotations : NSObject<MKAnnotation>
@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subtitle;

- (id)initWithDictionary:(NSDictionary *)dict;
@end
