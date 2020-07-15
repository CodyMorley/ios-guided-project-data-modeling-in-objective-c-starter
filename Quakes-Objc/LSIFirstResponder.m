//
//  LSIFirstResponder.m
//  Quakes-Objc
//
//  Created by Cody Morley on 7/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIFirstResponder.h"

@implementation LSIFirstResponder

@synthesize name = _name;

- (NSString *)name
{
    return _name;
}

//property declaration of copy creates a "contract" you must call copy if you set copy.

- (void)setName:(NSString *)name
{
    //anything you call here; before setting the value, is an equivalent to 'willSet'
    NSLog(@"Previous name is %@", self.name);
    _name = [name copy];
    //anything you call here; after setting the value, is an equivalent to 'didSet'
    NSLog(@"New name is %@", self.name);
}

@end
