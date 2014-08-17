//
//  BTINSMutableArrayTests.m
//  BTIKitDemoProject
//
//  Created by Brian Slick on 4/1/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSMutableArray+BTIKitAdditions.h"

@interface BTINSMutableArrayTests : XCTestCase

@end

@implementation BTINSMutableArrayTests

- (void)testRemovingFirstObjectFromPopulatedArray
{
    NSMutableArray *testArray = [NSMutableArray arrayWithObjects:@"Red", @"Green", @"Blue", nil];
    
    [testArray removeFirstObjectBTI];
    
    XCTAssertEqualObjects(@"Green", [testArray firstObject], @"First object should have been removed");
}

- (void)testRemovingFirstObjectFromEmptyArray
{
    NSMutableArray *testArray = [NSMutableArray array];
    
    [testArray removeFirstObjectBTI];
    
    XCTAssertTrue([testArray count] == 0, @"The array should still be empty, and without crashing");
}

- (void)testMovingObjectToDifferentIndex
{
    NSMutableArray *sourceArray = [NSMutableArray arrayWithObjects:@"Red", @"Green", @"Blue", nil];
    NSArray *finalArray = [NSArray arrayWithObjects:@"Green", @"Blue", @"Red", nil];
    
    [sourceArray moveObjectAtIndexBTI:0 toIndex:2];
    
    XCTAssertEqualObjects(sourceArray, finalArray, @"The array contents should have been reordered");
}

- (void)testAddingPopulatedString
{
    NSMutableArray *array = [NSMutableArray array];
    
    [array safelyAddPopulatedStringBTI:@"Test"];
    
    XCTAssertEqual(1, [array count], @"String should have been added");
}

- (void)testAddingEmptyString
{
    NSMutableArray *array = [NSMutableArray array];

    [array safelyAddPopulatedStringBTI:@""];
    
    XCTAssertEqual(0, [array count], @"String should not have been added");
}

- (void)testAddingNil
{
    NSMutableArray *array = [NSMutableArray array];
    
    [array safelyAddPopulatedStringBTI:nil];

    XCTAssertEqual(0, [array count], @"String should not have been added");
}

- (void)testAddingNonStringObject
{
    NSMutableArray *array = [NSMutableArray array];
    
    id object = [NSNull null];
    
    [array safelyAddPopulatedStringBTI:object];
    
    XCTAssertEqual(0, [array count], @"Object should not have been added");
}

@end
