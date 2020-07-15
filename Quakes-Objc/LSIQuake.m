//
//  LSIQuake.m
//  Quakes-Objc
//
//  Created by Cody Morley on 7/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIQuake.h"

@implementation LSIQuake

- (instancetype)initWithMagnitude:(double)magnitude
                            place:(NSString *)place
                             time:(NSDate *)time
                            alert:(NSString *)alert
                             type:(NSString *)type
                         latitude:(double)latitude
                        longitude:(double)longitude
{
    self = [super init];
    if (self) {
        _magnitude = magnitude;
        _place = [place copy];
        _time = time;
        _alert = [alert copy];
        _type = [type copy];
        _latitude = latitude;
        _longitude = longitude;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSDictionary *propertiesDictionary = dictionary[@"properties"];
    NSDictionary *geometryDictionary = dictionary[@"geometry"];
    NSNumber *magnitude = propertiesDictionary[@"mag"];
    NSString *place = propertiesDictionary[@"place"];
    NSNumber *timeNumber = propertiesDictionary[@"time"];
    NSDate *time = [NSDate dateWithTimeIntervalSince1970: timeNumber.longValue / 1000];
    
    NSString *alert = propertiesDictionary[@"alert"];
    if ([alert isKindOfClass: [NSNull class]]) {
        alert = @"";
    }
    
    NSString *type = propertiesDictionary[@"type"];
    
    
    NSArray *coordinates = geometryDictionary[@"coordinates"];
    NSNumber *longitudeNumber = nil;
    NSNumber *latitudeNumber = nil;
    if (coordinates.count >= 2) {
        longitudeNumber = coordinates[0];
        latitudeNumber = coordinates[1];
    }
    
    if (!(magnitude && place && time && latitudeNumber && longitudeNumber)) {
        return nil;
    }
    
    self = [self initWithMagnitude:magnitude.doubleValue
                             place:place
                              time:time
                             alert:alert
                              type:type
                          latitude:latitudeNumber.doubleValue
                         longitude:longitudeNumber.doubleValue];
    return self;
}

@end
