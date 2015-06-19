//
//  BTITableContentsManagerTests.m
//  BTIKitDemoProject
//
//  Created by Brian Slick on 4/2/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BTITableContentsManager.h"
#import "BTITableSectionInfo.h"
#import "BTITableRowInfo.h"

#define kNumberOfSections           4

@interface BTITableContentsManagerTests : XCTestCase

@property (nonatomic, strong) BTITableContentsManager *contentsManager;

@end

@implementation BTITableContentsManagerTests

- (void)setUp
{
    [super setUp];

    BTITableContentsManager *contentsManager = [[BTITableContentsManager alloc] init];
    [self setContentsManager:contentsManager];
    
    for (NSInteger sectionIndex = 0; sectionIndex < kNumberOfSections; sectionIndex++)
    {
        BTITableSectionInfo *section = [contentsManager dequeueReusableSectionInfoAndAddToContents];
        [section setIdentifier:[NSString stringWithFormat:@"Section %ld Identifier", (long)sectionIndex]];
        [section setRepresentedObject:[NSString stringWithFormat:@"Section %ld", (long)sectionIndex]];
        [section setHeaderTitle:[NSString stringWithFormat:@"Section %ld Header", (long)sectionIndex]];
        [section setFooterTitle:[NSString stringWithFormat:@"Section %ld Footer", (long)sectionIndex]];
        [section setSectionIndexTitle:[NSString stringWithFormat:@"%ld", (long)sectionIndex]];
        
        for (NSInteger rowIndex = 0; rowIndex < sectionIndex + 1; rowIndex++)
        {
            BTITableRowInfo *rowInfo = [contentsManager dequeueReusableRowInfo];
            [section addRowsObject:rowInfo];
            
            NSString *location = [NSString stringWithFormat:@"Section %ld Row %ld", (long)sectionIndex, (long)rowIndex];
            
            [rowInfo setIdentifier:[location stringByAppendingString:@" Identifier"]];
            [rowInfo setText:[location stringByAppendingString:@" Text"]];
            [rowInfo setRepresentedObject:location];
            [rowInfo setRowHeight:(rowIndex + 1) * 20.0];
        }
    }
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testAddingASectionManually
{
    BTITableContentsManager *manager = [self contentsManager];
    
    [manager reset];
    
    BTITableSectionInfo *sectionInfo = [manager dequeueReusableSectionInfo];
    XCTAssertNotNil(sectionInfo, @"A section info object should have been created");
    
    XCTAssert([manager numberOfSections] == 0, @"There should be no sections in the manager");
    
    [manager addSectionInfo:sectionInfo];
    
    XCTAssert([manager numberOfSections] == 1, @"There should be one section in the manager");
}

- (void)testAddingASectionAutomatically
{
    BTITableContentsManager *manager = [self contentsManager];
    
    [manager reset];
    
    __unused BTITableSectionInfo *sectionInfo = [manager dequeueReusableSectionInfoAndAddToContents];

    XCTAssertEqual(1, [manager numberOfSections], @"There should be one section in the manager");
}

- (void)testAddingRowsManually
{
    BTITableContentsManager *manager = [self contentsManager];
    
    [manager reset];

    BTITableRowInfo *row1 = [manager dequeueReusableRowInfo];
    BTITableRowInfo *row2 = [manager dequeueReusableRowInfo];
    BTITableRowInfo *row3 = [manager dequeueReusableRowInfo];

    XCTAssertNotNil(row1, @"A row info object should have been created");
    XCTAssertNotNil(row2, @"A row info object should have been created");
    XCTAssertNotNil(row3, @"A row info object should have been created");

    [manager addRowInfo:row1 makeNewSection:NO];
    XCTAssert([manager numberOfSections] == 1, @"There should be one section in the manager");

    [manager reset];
    
    [manager addRowInfo:row1 makeNewSection:YES];
    XCTAssert([manager numberOfSections] == 1, @"There should be one section in the manager");

    [manager addRowInfo:row2 makeNewSection:YES];
    XCTAssert([manager numberOfSections] == 2, @"There should be two sections in the manager");

    [manager addRowInfo:row3 makeNewSection:NO];
    XCTAssert([manager numberOfSections] == 2, @"There should be two sections in the manager");

    BTITableSectionInfo *section1 = [manager sectionInfoAtIndex:0];
    XCTAssert([section1 countOfRows] == 1, @"There should be one row in the first section");
    
    BTITableSectionInfo *section2 = [manager sectionInfoAtIndex:1];
    XCTAssert([section2 countOfRows] == 2, @"There should be two rows in the second section");
}

- (void)testAddingRowsAutomatically
{
    BTITableContentsManager *manager = [self contentsManager];
    
    [manager reset];
    
    BTITableRowInfo *row1 = [manager dequeueReusableRowInfoAndAddToContents];
    BTITableRowInfo *row2 = [manager dequeueReusableRowInfoAndAddToContents];
    BTITableRowInfo *row3 = [manager dequeueReusableRowInfoAndAddToContents];
    
    XCTAssertNotNil(row1, @"A row info object should have been created");
    XCTAssertNotNil(row2, @"A row info object should have been created");
    XCTAssertNotNil(row3, @"A row info object should have been created");

    XCTAssert([manager numberOfSections] == 1, @"There should be only 1 section");
    XCTAssert([manager numberOfRowsInSection:0] == 3, @"There should be 3 rows");
}

- (void)testNumberOfSections
{
    XCTAssert([[self contentsManager] numberOfSections] == 4, @"There should be 4 sections");
}

- (void)testHeaderTitles
{
    BTITableContentsManager *manager = [self contentsManager];
    
    XCTAssertEqualObjects(@"Section 0 Header", [manager headerTitleInSection:0], @"Section header is not correct");
    XCTAssertEqualObjects(@"Section 1 Header", [manager headerTitleInSection:1], @"Section header is not correct");
    XCTAssertEqualObjects(@"Section 2 Header", [manager headerTitleInSection:2], @"Section header is not correct");
    XCTAssertEqualObjects(@"Section 3 Header", [manager headerTitleInSection:3], @"Section header is not correct");
}

- (void)testFooterTitles
{
    BTITableContentsManager *manager = [self contentsManager];
    
    XCTAssertEqualObjects(@"Section 0 Footer", [manager footerTitleInSection:0], @"Section footer is not correct");
    XCTAssertEqualObjects(@"Section 1 Footer", [manager footerTitleInSection:1], @"Section footer is not correct");
    XCTAssertEqualObjects(@"Section 2 Footer", [manager footerTitleInSection:2], @"Section footer is not correct");
    XCTAssertEqualObjects(@"Section 3 Footer", [manager footerTitleInSection:3], @"Section footer is not correct");
}

- (void)testNumberOfRowsInSection
{
    BTITableContentsManager *manager = [self contentsManager];
    
    XCTAssertEqual(1, [manager numberOfRowsInSection:0], @"There should be 1 row in this section");
    XCTAssertEqual(2, [manager numberOfRowsInSection:1], @"There should be 2 rows in this section");
    XCTAssertEqual(3, [manager numberOfRowsInSection:2], @"There should be 3 rows in this section");
    XCTAssertEqual(4, [manager numberOfRowsInSection:3], @"There should be 4 rows in this section");
}

- (void)testHeightForRowAtIndexPath
{
    BTITableContentsManager *manager = [self contentsManager];
    
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:0 inSection:3];
    NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:1 inSection:3];
    NSIndexPath *indexPath3 = [NSIndexPath indexPathForRow:2 inSection:3];
    NSIndexPath *indexPath4 = [NSIndexPath indexPathForRow:3 inSection:3];
    
    XCTAssertEqual(44.0, [manager heightForRowAtIndexPath:indexPath1], @"Row height is not correct");   // Minimum height
    XCTAssertEqual(44.0, [manager heightForRowAtIndexPath:indexPath2], @"Row height is not correct");   // Minimum height
    XCTAssertEqual(60.0, [manager heightForRowAtIndexPath:indexPath3], @"Row height is not correct");
    XCTAssertEqual(80.0, [manager heightForRowAtIndexPath:indexPath4], @"Row height is not correct");
}

- (void)testSectionIndexTitles
{
    BTITableContentsManager *manager = [self contentsManager];
    
    BTITableSectionInfo *sectionInfo = [manager sectionInfoAtIndex:2];
    [sectionInfo setSectionIndexTitle:nil];
    
    NSArray *idealSectionTitles = @[ @"0", @"1", @"", @"3" ];
    
    XCTAssertEqualObjects(idealSectionTitles, [manager sectionIndexTitles], @"Section titles are not correct");
}

- (void)testSectionInfoAtIndex
{
    BTITableContentsManager *manager = [self contentsManager];

    BTITableSectionInfo *section1 = [manager sectionInfoAtIndex:0];
    BTITableSectionInfo *section2 = [manager sectionInfoAtIndex:1];
    BTITableSectionInfo *section3 = [manager sectionInfoAtIndex:2];
    BTITableSectionInfo *section4 = [manager sectionInfoAtIndex:3];

    XCTAssertEqualObjects(@"Section 0 Header", [section1 headerTitle], @"Section header is not correct");
    XCTAssertEqualObjects(@"Section 1 Header", [section2 headerTitle], @"Section header is not correct");
    XCTAssertEqualObjects(@"Section 2 Header", [section3 headerTitle], @"Section header is not correct");
    XCTAssertEqualObjects(@"Section 3 Header", [section4 headerTitle], @"Section header is not correct");
}

- (void)testSectionInfoForIdentifier
{
    BTITableContentsManager *manager = [self contentsManager];
    
    BTITableSectionInfo *noIdentifierSection = [manager sectionInfoForIdentifier:nil];
    BTITableSectionInfo *identifierSection = [manager sectionInfoForIdentifier:@"Section 2 Identifier"];
    
    XCTAssertNil(noIdentifierSection, @"Should not have found a section");
    XCTAssertEqualObjects(@"Section 2 Header", [identifierSection headerTitle], @"Retrieved section is not correct");
}

- (void)testRepresentedSectionObject
{
    BTITableContentsManager *manager = [self contentsManager];
    
    BTITableSectionInfo *section1 = [manager sectionInfoAtIndex:0];
    BTITableSectionInfo *section2 = [manager sectionInfoAtIndex:1];
    BTITableSectionInfo *section3 = [manager sectionInfoAtIndex:2];
    BTITableSectionInfo *section4 = [manager sectionInfoAtIndex:3];
    
    XCTAssertEqualObjects(@"Section 0", [section1 representedObject], @"Represented object is not correct");
    XCTAssertEqualObjects(@"Section 1", [section2 representedObject], @"Represented object is not correct");
    XCTAssertEqualObjects(@"Section 2", [section3 representedObject], @"Represented object is not correct");
    XCTAssertEqualObjects(@"Section 3", [section4 representedObject], @"Represented object is not correct");
}

- (void)testRowInfoAtIndexPath
{
    BTITableContentsManager *manager = [self contentsManager];

    NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *secondIndexPath = [NSIndexPath indexPathForRow:2 inSection:2];
    
    BTITableRowInfo *firstRowInfo = [manager rowInfoAtIndexPath:firstIndexPath];
    BTITableRowInfo *secondRowInfo = [manager rowInfoAtIndexPath:secondIndexPath];

    XCTAssertEqualObjects(@"Section 0 Row 0 Text", [firstRowInfo text], @"Row info text is not correct");
    XCTAssertEqualObjects(@"Section 2 Row 2 Text", [secondRowInfo text], @"Row info text is not correct");
}

- (void)testRowInfoForIdentifier
{
    BTITableContentsManager *manager = [self contentsManager];
    
    BTITableRowInfo *noIdentifierRow = [manager rowInfoForIdentifier:nil];
    BTITableRowInfo *identifierRow = [manager rowInfoForIdentifier:@"Section 1 Row 1 Identifier"];
    
    XCTAssertNil(noIdentifierRow, @"Should not have found a row info");
    XCTAssertEqualObjects(@"Section 1 Row 1 Text", [identifierRow text], @"Retrieved row info is not correct");
}

- (void)testRepresentedObjectAtIndexPath
{
    BTITableContentsManager *manager = [self contentsManager];
    
    NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *secondIndexPath = [NSIndexPath indexPathForRow:2 inSection:2];
    
    BTITableRowInfo *firstRowInfo = [manager rowInfoAtIndexPath:firstIndexPath];
    BTITableRowInfo *secondRowInfo = [manager rowInfoAtIndexPath:secondIndexPath];
    
    XCTAssertEqualObjects(@"Section 0 Row 0", [firstRowInfo representedObject], @"Represented object is not correct");
    XCTAssertEqualObjects(@"Section 2 Row 2", [secondRowInfo representedObject], @"Represented object is not correct");
}

- (void)testIndexOfSectionInfo
{
    BTITableContentsManager *manager = [self contentsManager];

    NSInteger targetIndex = 2;
    
    BTITableSectionInfo *sectionInfo = [[manager sections] objectAtIndex:targetIndex];
    
    XCTAssertEqual(targetIndex, [manager indexOfSectionInfo:sectionInfo], @"Wrong section index");
}

- (void)testIndexOfRepresentedSectionObject
{
    BTITableContentsManager *manager = [self contentsManager];
    
    NSInteger targetIndex = 2;
    
    NSString *representedObject = @"Section 2";
    
    XCTAssertEqual(targetIndex, [manager indexOfRepresentedSectionObject:representedObject], @"Wrong section index");
}

- (void)testIndexOfSectionIdentifier
{
    BTITableContentsManager *manager = [self contentsManager];
    
    NSInteger targetIndex = 2;
    
    NSString *sectionIdentifier = @"Section 2 Identifier";
    
    XCTAssertEqual(targetIndex, [manager indexOfSectionIdentifier:sectionIdentifier], @"Wrong section index");
}

- (void)testIndexPathOfRowInfo
{
    BTITableContentsManager *manager = [self contentsManager];

    NSIndexPath *targetIndexPath = [NSIndexPath indexPathForRow:2 inSection:2];
    
    BTITableSectionInfo *sectionInfo = [manager sectionInfoAtIndex:[targetIndexPath section]];
    BTITableRowInfo *rowInfo = [sectionInfo objectInRowsAtIndex:[targetIndexPath row]];
    
    XCTAssertEqualObjects(targetIndexPath, [manager indexPathOfRowInfo:rowInfo], @"Wrong index path");
}

- (void)testIndexPathOfRepresentedRowObject
{
    BTITableContentsManager *manager = [self contentsManager];
    
    NSIndexPath *targetIndexPath = [NSIndexPath indexPathForRow:2 inSection:2];
    
    NSString *representedObject = @"Section 2 Row 2";
    
    NSIndexPath *actualIndexPath = [manager indexPathOfRepresentedRowObject:representedObject];
    BOOL thisIsAWorkaroundToFindOutIfTheyAreEqual = [targetIndexPath isEqual:actualIndexPath];
    
    XCTAssertTrue(thisIsAWorkaroundToFindOutIfTheyAreEqual, @"Wrong index path");
//    XCTAssertEqual(targetIndexPath, actualIndexPath, @"Wrong index path");        // no idea why this isn't working
}

- (void)testIndexPathOfRowIdentifier
{
    BTITableContentsManager *manager = [self contentsManager];
    
    NSIndexPath *targetIndexPath = [NSIndexPath indexPathForRow:2 inSection:2];
    
    NSString *identifier = @"Section 2 Row 2 Identifier";
    
    XCTAssertEqualObjects(targetIndexPath, [manager indexPathOfRowIdentifier:identifier], @"Wrong index path");
}

- (void)testAllSectionIndexes
{
    BTITableContentsManager *manager = [self contentsManager];

    NSMutableIndexSet *targetIndexSet = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 4)];
    
    XCTAssertEqualObjects(targetIndexSet, [manager allSectionIndexes], @"Wrong indexes");
}

- (void)testAllIndexPaths
{
    BTITableContentsManager *manager = [self contentsManager];

    NSMutableArray *targetIndexPaths = [NSMutableArray array];
    
    for (NSInteger sectionIndex = 0; sectionIndex < kNumberOfSections; sectionIndex++)
    {
        for (NSInteger rowIndex = 0; rowIndex < sectionIndex + 1; rowIndex++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
            [targetIndexPaths addObject:indexPath];
        }
    }

    XCTAssertEqualObjects(targetIndexPaths, [manager allIndexPaths], @"Wrong index paths");
}

@end
