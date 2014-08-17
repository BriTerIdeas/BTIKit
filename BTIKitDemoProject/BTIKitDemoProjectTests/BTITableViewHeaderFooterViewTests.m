//
//  BTITableViewHeaderFooterViewTests.m
//  BTIKitDemoProject
//
//  Created by Brian Slick on 8/16/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BTITableViewHeaderFooterView.h"
#import "SampleTableHeaderFooterView.h"

@interface BTITableViewHeaderFooterViewTests : XCTestCase

@end

@implementation BTITableViewHeaderFooterViewTests

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
    XCTAssertEqualObjects(@"BTITableViewHeaderFooterView", [BTITableViewHeaderFooterView reuseIdentifierBTI], @"Reuse identifier is wrong");
}

- (void)testRegisterNib
{
    UITableView *tableView = [[UITableView alloc] init];
    
    [SampleTableHeaderFooterView registerNibForTableViewBTI:tableView];
    
    SampleTableHeaderFooterView *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[SampleTableHeaderFooterView reuseIdentifierBTI]];
    
    XCTAssertNotNil(cell, @"Should have created a view");
}

- (void)testDequeueView
{
    UITableView *tableView = [[UITableView alloc] init];
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([SampleTableHeaderFooterView class]) bundle:nil];
    [tableView registerNib:nib forHeaderFooterViewReuseIdentifier:[SampleTableHeaderFooterView reuseIdentifierBTI]];
    
    SampleTableHeaderFooterView *view = [SampleTableHeaderFooterView dequeueHeaderFooterViewFromTableViewBTI:tableView];
    
    XCTAssertNotNil(view, @"Should have created a view");
}

@end
