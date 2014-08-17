//
//  BTINSStringTests.m
//  BTIKitDemoProject
//
//  Created by Brian Slick on 8/15/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSString+BTIKitAdditions.h"

@interface BTINSStringTests : XCTestCase

@end

@implementation BTINSStringTests

- (void)testEmptyStringPopulated
{
    XCTAssertTrue([@"blah" isNotEmptyBTI], @"String should not be empty");
}

- (void)testEmptyStringEmpty
{
    XCTAssertFalse([@"" isNotEmptyBTI], @"String should be empty");
}

- (void)testEmptyStringNil
{
    NSString *string = nil;
    
    XCTAssertFalse([string isNotEmptyBTI], @"Nil should be considered empty");
}

- (void)testValidEmail
{
    XCTAssertTrue([@"brian@brian.com" isValidEmailAddressBTI], @"String should be a valid email");
}

- (void)testInvalidEmail
{
    XCTAssertFalse([@"1234567890" isValidEmailAddressBTI], @"String should not be a valid email");
}

@end
