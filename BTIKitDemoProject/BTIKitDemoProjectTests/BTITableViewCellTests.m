//
//  BTITableViewCellTests.m
//  BTIKitDemoProject
//
//  Created by Brian Slick on 4/3/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BTITableViewCell.h"

@interface BTITableViewCellTests : XCTestCase

@end

@implementation BTITableViewCellTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testReuseIdentifier
{
    XCTAssertEqualObjects(@"BTITableViewCell", [BTITableViewCell reuseIdentifierBTI], @"Reuse identifier is wrong");
}

@end
