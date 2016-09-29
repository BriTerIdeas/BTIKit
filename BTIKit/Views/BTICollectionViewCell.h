//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.6
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

/*
 
 OVERVIEW
 
 This class overrides the reuseIdentifier to match the class name.  A class method is also provided to return that name.  This does work with XIB-based cells.  This avoids the issue of forgetting to specify the cell identifier in the XIB.  Naturally this will only work if all cells powered by this class should have the same reuse identifier.
 
 */

// Libraries
#import <UIKit/UIKit.h>

// Forward Declarations and Classes

// Public Constants

// Protocols

@interface BTICollectionViewCell : UICollectionViewCell

// Public Properties


// Public Methods

/**
 Returns the class name as a string
 
 @return The class name as a string
 */
+ (NSString *)reuseIdentifierBTI;

/**
 Creates and registers a UINib object matching the class name with the provided collection view
 
 @param collectionView The UICollectionView object with which to register the Nib
 */
+ (void)registerNibForCollectionViewBTI:(UICollectionView *)collectionView;

/**
 Dequeues a reusable cell of receiver's class type from the provided collection view, or nil if no nib is registered.
 
 @param collectionView the UICollectionView object from which to dequeue a cell.
 @param indexPath The index path specifying the location of the cell.
 */
+ (instancetype)dequeueCellFromCollectionViewBTI:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;

@end
