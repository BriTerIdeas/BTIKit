//
//  BTICollectionViewCellTests.m
//  BTIKitDemoProject
//
//  Created by Brian Slick on 8/16/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BTICollectionViewCell.h"
#import "SampleCollectionViewCell1.h"

@interface BTICollectionViewCellTests : XCTestCase <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation BTICollectionViewCellTests

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
    XCTAssertEqualObjects(@"BTICollectionViewCell", [BTICollectionViewCell reuseIdentifierBTI], @"Reuse identifier is wrong");
}

- (void)testRegisterNib
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0, 100.0) collectionViewLayout:flowLayout];
    [collectionView setDataSource:self];
    [collectionView setDelegate:self];
    
    [SampleCollectionViewCell1 registerNibForCollectionViewBTI:collectionView];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    SampleCollectionViewCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SampleCollectionViewCell1 reuseIdentifierBTI] forIndexPath:indexPath];
    
    XCTAssertNotNil(cell, @"Should have created a cell");
}

- (void)testDequeueCell
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0, 100.0) collectionViewLayout:flowLayout];
    [collectionView setDataSource:self];
    [collectionView setDelegate:self];

    UINib *nib = [UINib nibWithNibName:NSStringFromClass([SampleCollectionViewCell1 class]) bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:[SampleCollectionViewCell1 reuseIdentifierBTI]];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    SampleCollectionViewCell1 *cell = [SampleCollectionViewCell1 dequeueCellFromCollectionViewBTI:collectionView forIndexPath:indexPath];
    
    XCTAssertNotNil(cell, @"Should have created a cell");
}

#pragma mark - UICollectionViewDataSource Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SampleCollectionViewCell1 *cell = [SampleCollectionViewCell1 dequeueCellFromCollectionViewBTI:collectionView forIndexPath:indexPath];
    return cell;
}

@end
