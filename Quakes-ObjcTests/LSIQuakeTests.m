//
//  LSIQuakeTests.m
//  Quakes-ObjcTests
//
//  Created by Cody Morley on 7/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSIFileHelper.h"
#import "LSILog.h"
#import "LSIQuake.h"

@interface LSIQuakeTests : XCTestCase

@end

@implementation LSIQuakeTests


- (void)testQuakeParsing
{
    NSData *quakeData = loadFile(@"Quake.json", [LSIQuakeTests class]);
    NSLog(@"Quake %@", quakeData);
    
    // NSData -> Dictionary -> LSIQuake ; use json serialization
    //NSData -> Dictionary
    NSError *jsonError = nil;
    NSDictionary *quakeDictionary = [NSJSONSerialization JSONObjectWithData: quakeData
                                                                    options: 0
                                                                      error: &jsonError]; //& is a pointer to a * used as @escaping
    //Dictionary -> LSIQuake
    LSIQuake *quake = [[LSIQuake alloc] initWithDictionary:quakeDictionary];
    NSDate *time = [NSDate dateWithTimeIntervalSince1970: 1388620296020 / 1000];
    
    XCTAssertEqualWithAccuracy(1.29, quake.magnitude, 0.001);
    XCTAssertEqualObjects(@"10km SSW of Idyllwild, CA", quake.place);
    //XCTAssertEqualObjects(time, quake.time);
    XCTAssertEqualObjects(@"", quake.alert);
    XCTAssertEqualWithAccuracy(33.663333299999998, quake.latitude, 0.0001);
    XCTAssertEqualWithAccuracy(-116.7776667, quake.longitude, 0.0001);
}

@end
