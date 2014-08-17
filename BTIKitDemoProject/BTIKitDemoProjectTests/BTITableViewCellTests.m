//
//  BTITableViewCellTests.m
//  BTIKitDemoProject
//
//  Created by Brian Slick on 4/3/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BTITableViewCell.h"
#import "SampleTableViewCell1.h"

@interface BTITableViewCellTests : XCTestCase

@end

@implementation BTITableViewCellTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testReuseIdentifier
{
    XCTAssertEqualObjects(@"BTITableViewCell", [BTITableViewCell reuseIdentifierBTI], @"Reuse identifier is wrong");
}

- (void)testRegisterNib
{
    UITableView *tableView = [[UITableView alloc] init];
    
    [SampleTableViewCell1 registerNibForTableViewBTI:tableView];
    
    SampleTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:[SampleTableViewCell1 reuseIdentifierBTI]];
    
    XCTAssertNotNil(cell, @"Should have created a cell");
}

- (void)testDequeueCell
{
    UITableView *tableView = [[UITableView alloc] init];

    UINib *nib = [UINib nibWithNibName:NSStringFromClass([SampleTableViewCell1 class]) bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:[SampleTableViewCell1 reuseIdentifierBTI]];
    
    SampleTableViewCell1 *cell = [SampleTableViewCell1 dequeueCellFromTableViewBTI:tableView];
    
    XCTAssertNotNil(cell, @"Should have created a cell");
}

@end
