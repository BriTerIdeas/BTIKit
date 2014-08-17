//
//  BTIUITableViewHeaderFooterViewTests.m
//  BTIKitDemoProject
//
//  Created by Brian Slick on 8/16/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BTIKit.h"
#import "SampleTableHeaderFooterView.h"

@interface BTIUITableViewHeaderFooterViewTests : XCTestCase

@end

@implementation BTIUITableViewHeaderFooterViewTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testLoadingViewFromNibWithNameProvided
{
    SampleTableHeaderFooterView *view = [SampleTableHeaderFooterView headerFooterViewFromNibNameBTI:NSStringFromClass([SampleTableHeaderFooterView class])];
    
    BOOL isRightKindOfView = [view isKindOfClass:[SampleTableHeaderFooterView class]];
    
    XCTAssertNotNil(view, @"Should have created a view");
    XCTAssertTrue(isRightKindOfView, @"Did not get the right view class");
}

- (void)testLoadingViewFromNibWithNilNameProvided
{
    SampleTableHeaderFooterView *view = [SampleTableHeaderFooterView headerFooterViewFromNibNameBTI:nil];
    
    BOOL isRightKindOfView = [view isKindOfClass:[SampleTableHeaderFooterView class]];
    
    XCTAssertNotNil(view, @"Should have created a view");
    XCTAssertTrue(isRightKindOfView, @"Did not get the right view class");
}

- (void)testLoadingCellFromNibWithoutName
{
    SampleTableHeaderFooterView *view = [SampleTableHeaderFooterView headerFooterViewFromNibBTI];
    
    BOOL isRightKindOfView = [view isKindOfClass:[SampleTableHeaderFooterView class]];
    
    XCTAssertNotNil(view, @"Should have created a view");
    XCTAssertTrue(isRightKindOfView, @"Did not get the right view class");
}

@end
