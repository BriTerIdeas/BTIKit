//
//  BTITableSectionInfoTests.m
//  BTIKitDemoProject
//
//  Created by Brian Slick on 4/2/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BTITableSectionInfo.h"
#import "BTITableRowInfo.h"

@interface BTITableSectionInfoTests : XCTestCase

@property (nonatomic, strong) BTITableSectionInfo *tableSectionInfo;
@end

@implementation BTITableSectionInfoTests

- (void)setUp
{
    [super setUp];
    
    [self setUpBasicScenario];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)setUpBasicScenario
{
    BTITableSectionInfo *sectionInfo = [[BTITableSectionInfo alloc] init];
    [self setTableSectionInfo:sectionInfo];
    
    [sectionInfo setIdentifier:@"Test Info Identifier"];
    [sectionInfo setRepresentedObject:@"Test Info Represented Object"];
    
    [sectionInfo addRowsObjectsFromArray:@[ @"Red", @"Green", @"Blue" ]];
    
    [sectionInfo setHeaderTitle:@"Test Header Title"];
    [sectionInfo setFooterTitle:@"Test Footer Title"];
    [sectionInfo setSectionIndexTitle:@"G"];
}

#pragma mark - Basic Scenario Tests

- (void)testThatAllValuesAreClearedUponReset
{
    BTITableSectionInfo *sectionInfo = [self tableSectionInfo];
    
    [sectionInfo reset];
    
    XCTAssertNil([sectionInfo identifier], @"Identifier was not cleared out");
    
    XCTAssertNil([sectionInfo representedObject], @"Represented object was not cleared out");
    
    XCTAssertTrue([sectionInfo countOfRows] == 0, @"Contents should have been emptied");
    
    XCTAssertNil([sectionInfo headerTitle], @"Header was not cleared out");
    XCTAssertNil([sectionInfo footerTitle], @"Footer was not cleared out");
    XCTAssertNil([sectionInfo sectionIndexTitle], @"Index title was not cleared out");
}

- (void)testThatParentSectionInfoIsPopulatedForRowInfo
{
    BTITableSectionInfo *sectionInfo = [self tableSectionInfo];
    
    [sectionInfo reset];

    BTITableRowInfo *rowInfo = [[BTITableRowInfo alloc] init];
    
    [sectionInfo addRowsObject:rowInfo];
    
    XCTAssertEqualObjects(sectionInfo, [rowInfo parentSectionInfo], @"Row info should have a parent section info");
}

- (void)testCountOfRows
{
    XCTAssertEqual([[self tableSectionInfo] countOfRows], 3, @"Wrong number of rows");
}

- (void)testObjectAtIndex
{
    BTITableSectionInfo *sectionInfo = [self tableSectionInfo];

    XCTAssertEqualObjects([sectionInfo objectInRowsAtIndex:0], @"Red", @"Wrong row value");
    XCTAssertEqualObjects([sectionInfo objectInRowsAtIndex:1], @"Green", @"Wrong row value");
    XCTAssertEqualObjects([sectionInfo objectInRowsAtIndex:2], @"Blue", @"Wrong row value");
}

- (void)testAddObject
{
    BTITableSectionInfo *sectionInfo = [self tableSectionInfo];
    
    [sectionInfo addRowsObject:@"Purple"];
    
    XCTAssertEqual([sectionInfo countOfRows], 4, @"Wrong number of rows");
    XCTAssertEqualObjects([sectionInfo objectInRowsAtIndex:3], @"Purple", @"Wrong row value");
}

- (void)testAddObjectsFromArray
{
    BTITableSectionInfo *sectionInfo = [self tableSectionInfo];
    
    [sectionInfo addRowsObjectsFromArray:@[ @"Aqua", @"Pink", @"Yellow" ]];
    
    XCTAssertEqual([sectionInfo countOfRows], 6, @"Wrong number of rows");
    XCTAssertEqualObjects([sectionInfo objectInRowsAtIndex:3], @"Aqua", @"Wrong row value");
    XCTAssertEqualObjects([sectionInfo objectInRowsAtIndex:4], @"Pink", @"Wrong row value");
    XCTAssertEqualObjects([sectionInfo objectInRowsAtIndex:5], @"Yellow", @"Wrong row value");
}

- (void)testAddObjectsFromSet
{
    BTITableSectionInfo *sectionInfo = [self tableSectionInfo];
    
    [sectionInfo addRowsObjectsFromSet:[NSSet setWithObjects:@"Aqua", @"Pink", @"Yellow", nil]];
    
    XCTAssertEqual([sectionInfo countOfRows], 6, @"Wrong number of rows");
}

- (void)testRemoveObject
{
    BTITableSectionInfo *sectionInfo = [self tableSectionInfo];

    [sectionInfo removeRowsObject:@"Green"];
    
    XCTAssertEqual([sectionInfo countOfRows], 2, @"Wrong number of rows");
    XCTAssertEqualObjects([sectionInfo objectInRowsAtIndex:1], @"Blue", @"Wrong row value");
}

- (void)testRemoveObjectAtIndex
{
    BTITableSectionInfo *sectionInfo = [self tableSectionInfo];
    
    [sectionInfo removeObjectFromRowsAtIndex:1];
    
    XCTAssertEqual([sectionInfo countOfRows], 2, @"Wrong number of rows");
    XCTAssertEqualObjects([sectionInfo objectInRowsAtIndex:1], @"Blue", @"Wrong row value");
}

- (void)testRemoveAllObjects
{
    BTITableSectionInfo *sectionInfo = [self tableSectionInfo];
    
    [sectionInfo removeAllRowsObjects];
    
    XCTAssertEqual([sectionInfo countOfRows], 0, @"Wrong number of rows");
}

- (void)testInsertObject
{
    BTITableSectionInfo *sectionInfo = [self tableSectionInfo];
    
    [sectionInfo insertObject:@"Purple" inRowsAtIndex:2];
    
    XCTAssertEqual([sectionInfo countOfRows], 4, @"Wrong number of rows");
    XCTAssertEqualObjects([sectionInfo objectInRowsAtIndex:2], @"Purple", @"Wrong row value");
}

- (void)testIndexOfObject
{
    BTITableSectionInfo *sectionInfo = [self tableSectionInfo];
    
    XCTAssertEqual([sectionInfo indexOfRowsObject:@"Green"], 1, @"Wrong index");
}

- (void)testSortUsingDescriptors
{
    BTITableSectionInfo *sectionInfo = [self tableSectionInfo];

    NSSortDescriptor *alphaSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    
    [sectionInfo sortRowsUsingDescriptors:@[ alphaSortDescriptor ]];
    
    XCTAssertEqualObjects([sectionInfo objectInRowsAtIndex:0], @"Blue", @"Wrong row value");
    XCTAssertEqualObjects([sectionInfo objectInRowsAtIndex:1], @"Green", @"Wrong row value");
    XCTAssertEqualObjects([sectionInfo objectInRowsAtIndex:2], @"Red", @"Wrong row value");
}

#pragma mark - Row Info Scenario Tests

- (void)setUpRowInfoScenario
{
    BTITableSectionInfo *sectionInfo = [self tableSectionInfo];

    [sectionInfo removeAllRowsObjects];
    
    for (NSInteger rowIndex = 0; rowIndex < 5; rowIndex++)
    {
        BTITableRowInfo *rowInfo = [[BTITableRowInfo alloc] init];
        [sectionInfo addRowsObject:rowInfo];
        
        NSString *location = [NSString stringWithFormat:@"Row %d", rowIndex];
        
        [rowInfo setIdentifier:[location stringByAppendingString:@" Identifier"]];
        [rowInfo setText:[location stringByAppendingString:@" Text"]];
        [rowInfo setRepresentedObject:location];
    }
}

- (void)testIndexOfIdentifier
{
    [self setUpRowInfoScenario];
    
    BTITableSectionInfo *sectionInfo = [self tableSectionInfo];

    XCTAssertEqual([sectionInfo indexOfIdentifier:@"Row 0 Identifier"], 0, @"Wrong index");
    XCTAssertEqual([sectionInfo indexOfIdentifier:@"Row 1 Identifier"], 1, @"Wrong index");
    XCTAssertEqual([sectionInfo indexOfIdentifier:@"Row 2 Identifier"], 2, @"Wrong index");
    XCTAssertEqual([sectionInfo indexOfIdentifier:@"Row 3 Identifier"], 3, @"Wrong index");
    XCTAssertEqual([sectionInfo indexOfIdentifier:@"Row 4 Identifier"], 4, @"Wrong index");
}

- (void)testIndexOfRepresentedObject
{
    [self setUpRowInfoScenario];
    
    BTITableSectionInfo *sectionInfo = [self tableSectionInfo];
    
    XCTAssertEqual([sectionInfo indexOfRepresentedObject:@"Row 0"], 0, @"Wrong index");
    XCTAssertEqual([sectionInfo indexOfRepresentedObject:@"Row 1"], 1, @"Wrong index");
    XCTAssertEqual([sectionInfo indexOfRepresentedObject:@"Row 2"], 2, @"Wrong index");
    XCTAssertEqual([sectionInfo indexOfRepresentedObject:@"Row 3"], 3, @"Wrong index");
    XCTAssertEqual([sectionInfo indexOfRepresentedObject:@"Row 4"], 4, @"Wrong index");
}

@end
