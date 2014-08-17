//
//  UICollectionView+BTIKitAdditions.m
//  BTIKit
//  v1.1
//
//  Created by Brian Slick in August 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

#import "UICollectionView+BTIKitAdditions.h"

#import "BTIKit.h"

@implementation UICollectionView (BTIKitAdditions)

- (NSIndexPath *)indexPathForItemContainingViewBTI:(UIView *)view
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    CGPoint correctedPoint = [view convertPoint:[view bounds].origin toView:self];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return [self indexPathForItemAtPoint:correctedPoint];
}

@end
