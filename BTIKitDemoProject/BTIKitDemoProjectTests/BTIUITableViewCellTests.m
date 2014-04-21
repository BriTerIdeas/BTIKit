//
//  BTIUITableViewCellTests.m
//  BTIKitDemoProject
//
//  Created by Brian Slick on 4/4/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "UITableViewCell+BTIAdditions.h"
#import "SampleTableViewCell1.h"

@interface BTIUITableViewCellTests : XCTestCase

@end

@implementation BTIUITableViewCellTests

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

- (void)testEnclosingTableViewNotPresent
{
    BTITableViewCell *cell = [[BTITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Test"];
    
    XCTAssertNil([cell enclosingTableViewBTI], @"There should not be a table view");
}

- (void)testEnclosingTableViewPresent
{
    BTITableViewCell *cell = [[BTITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Test"];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0, 100.0) style:UITableViewStylePlain];
    [tableView addSubview:cell];
    
    XCTAssertEqualObjects(tableView, [cell enclosingTableViewBTI], @"There should be a table view");
}

- (void)testLoadingCellFromNibWithNameProvided
{
    SampleTableViewCell1 *cell = [SampleTableViewCell1 cellFromNibNameBTI:NSStringFromClass([SampleTableViewCell1 class])];
    
    BOOL isRightKindOfCell = [cell isKindOfClass:[SampleTableViewCell1 class]];
    
    XCTAssertNotNil(cell, @"Should have created a cell");
    XCTAssertTrue(isRightKindOfCell, @"Did not get the right cell class");
}

- (void)testLoadingCellFromNibWithNilNameProvided
{
    SampleTableViewCell1 *cell = [SampleTableViewCell1 cellFromNibNameBTI:nil];
    
    BOOL isRightKindOfCell = [cell isKindOfClass:[SampleTableViewCell1 class]];
    
    XCTAssertNotNil(cell, @"Should have created a cell");
    XCTAssertTrue(isRightKindOfCell, @"Did not get the right cell class");
}

- (void)testLoadingCellFromNibWithoutName
{
    SampleTableViewCell1 *cell = [SampleTableViewCell1 cellFromNibBTI];
    
    BOOL isRightKindOfCell = [cell isKindOfClass:[SampleTableViewCell1 class]];
    
    XCTAssertNotNil(cell, @"Should have created a cell");
    XCTAssertTrue(isRightKindOfCell, @"Did not get the right cell class");
}

@end
