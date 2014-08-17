//
//  BTIUICollectionViewCellTests.m
//  BTIKitDemoProject
//
//  Created by Brian Slick on 8/16/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BTIKit.h"
#import "SampleCollectionViewCell1.h"

@interface BTIUICollectionViewCellTests : XCTestCase

@end

@implementation BTIUICollectionViewCellTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testEnclosingCollectionViewNotPresent
{
    BTICollectionViewCell *cell = [[BTICollectionViewCell alloc] init];
    
    XCTAssertNil([cell enclosingCollectionViewBTI], @"There should not be a collection view");
}

- (void)testEnclosingCollectionViewPresent
{
    BTICollectionViewCell *cell = [[BTICollectionViewCell alloc] init];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0, 100.0) collectionViewLayout:flowLayout];
    [collectionView addSubview:cell];
    
    XCTAssertEqualObjects(collectionView, [cell enclosingCollectionViewBTI], @"There should be a collection view");
}

- (void)testLoadingCellFromNibWithNameProvided
{
    SampleCollectionViewCell1 *cell = [SampleCollectionViewCell1 cellFromNibNameBTI:NSStringFromClass([SampleCollectionViewCell1 class])];
    
    BOOL isRightKindOfCell = [cell isKindOfClass:[SampleCollectionViewCell1 class]];
    
    XCTAssertNotNil(cell, @"Should have created a cell");
    XCTAssertTrue(isRightKindOfCell, @"Did not get the right cell class");
}

- (void)testLoadingCellFromNibWithNilNameProvided
{
    SampleCollectionViewCell1 *cell = [SampleCollectionViewCell1 cellFromNibNameBTI:nil];
    
    BOOL isRightKindOfCell = [cell isKindOfClass:[SampleCollectionViewCell1 class]];
    
    XCTAssertNotNil(cell, @"Should have created a cell");
    XCTAssertTrue(isRightKindOfCell, @"Did not get the right cell class");
}

- (void)testLoadingCellFromNibWithoutName
{
    SampleCollectionViewCell1 *cell = [SampleCollectionViewCell1 cellFromNibBTI];
    
    BOOL isRightKindOfCell = [cell isKindOfClass:[SampleCollectionViewCell1 class]];
    
    XCTAssertNotNil(cell, @"Should have created a cell");
    XCTAssertTrue(isRightKindOfCell, @"Did not get the right cell class");
}

@end
