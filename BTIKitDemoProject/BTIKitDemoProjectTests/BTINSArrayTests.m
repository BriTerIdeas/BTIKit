//
//  BTINSArrayTests.m
//  BTIKitDemoProject
//
//  Created by Brian Slick on 10/3/16.
//  Copyright © 2016 BriTer Ideas LLC. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSArray+BTIKitAdditions.h"

@interface BTINSArrayTests : XCTestCase

@end

@implementation BTINSArrayTests

- (void)testRandomObjectInArray
{
    NSArray *testArray = @[ @"Red", @"Green", @"Blue" ];
    
    NSString *randomObject = [testArray objectAtRandomIndexBTI];
    
    XCTAssertNotNil(randomObject, @"Should have found an object");
}

- (void)testRandomObjectInEmptyArray
{
    NSArray *testArray = @[];
    
    NSString *randomObject = [testArray objectAtRandomIndexBTI];
    
    XCTAssertNil(randomObject, @"Should not have found an object");
}

@end
