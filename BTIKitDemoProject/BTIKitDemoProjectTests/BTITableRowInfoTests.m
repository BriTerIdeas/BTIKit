//
//  BTITableRowInfoTests.m
//  DemoProject
//
//  Created by Brian Slick on 4/1/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BTITableRowInfo.h"

@interface BTITableRowInfoTests : XCTestCase

@property (nonatomic, strong) BTITableRowInfo *tableRowInfo;
@property (nonatomic, assign, getter = isBlockExecuted) BOOL blockExecuted;

@end

@implementation BTITableRowInfoTests

- (void)setUp
{
    [super setUp];

    [self setBlockExecuted:NO];
    
    BTITableRowInfo *rowInfo = [[BTITableRowInfo alloc] init];
    [self setTableRowInfo:rowInfo];
    
    [rowInfo setIdentifier:@"Test Info Identifier"];
    [rowInfo setRepresentedObject:@"Test Info Represented Object"];
    
    [rowInfo setText:@"Test Info Text"];
    [rowInfo setDetailText:@"Test Info Detail Text"];
    [rowInfo setCellAccessoryType:UITableViewCellAccessoryCheckmark];
    [rowInfo setRowHeight:15.0];
    
    [rowInfo setImage:[[UIImage alloc] init]];
    [rowInfo setImageName:@"file.jpg"];
    [rowInfo setImageFileURL:[NSURL URLWithString:@"file.jpg"]];
    
    [rowInfo setRowSelectionBlock:^{
        
        NSLog(@"Row Selection Block");
        [self setBlockExecuted:YES];
        
    }];
    [rowInfo setRowAccessorySelectionBlock:^{
        
        NSLog(@"Row Accessory Selection Block");
        [self setBlockExecuted:YES];

    }];

}

- (void)tearDown
{
    [super tearDown];
}

- (void)testThatAllValuesAreClearedUponReset
{
    BTITableRowInfo *rowInfo = [self tableRowInfo];
    
    [rowInfo reset];
        
    XCTAssertNil([rowInfo identifier], @"Identifier was not cleared out");

    XCTAssertNil([rowInfo representedObject], @"Represented object was not cleared out");

    XCTAssertNil([rowInfo text], @"Text was not cleared out");
    XCTAssertNil([rowInfo detailText], @"Detail text was not cleared out");
    XCTAssertEqual(UITableViewCellAccessoryNone, [rowInfo cellAccessoryType], @"Cell accessory was not cleared out");
    XCTAssertEqual(0.0, [rowInfo rowHeight], @"Row height was not reset");
    
    XCTAssertNil([rowInfo image], @"Image was not cleared out");
    XCTAssertNil([rowInfo imageName], @"Image name was not cleared out");
    XCTAssertNil([rowInfo imageFileURL], @"Image file URL was not cleared out");
    
    XCTAssertNil([rowInfo rowSelectionBlock], @"Row selection block was not cleared out");
    XCTAssertNil([rowInfo rowAccessorySelectionBlock], @"Row accessory selection block was not cleared out");
}

- (void)testCellPopulation
{
    BTITableRowInfo *rowInfo = [self tableRowInfo];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Test"];
    
    [rowInfo populateCell:cell];
    
    XCTAssertEqualObjects(@"Test Info Text", [[cell textLabel] text], @"Cell's text label was not populated");
    XCTAssertEqualObjects(@"Test Info Detail Text", [[cell detailTextLabel] text], @"Cell's detail text label was not populated");
    XCTAssertEqual(UITableViewCellAccessoryCheckmark, [rowInfo cellAccessoryType], @"Cell accessory was not defined");
    XCTAssertNotNil([[cell imageView] image], @"Cell should have an image");
}

- (void)testRowSelection
{
    [[self tableRowInfo] executeRowSelectionBlock];
    
    XCTAssertTrue([self isBlockExecuted], @"Block was not executed");
}

- (void)testRowAccessorySelection
{
    [[self tableRowInfo] executeRowAccessorySelectionBlock];
    
    XCTAssertTrue([self isBlockExecuted], @"Block was not executed");
}

@end
