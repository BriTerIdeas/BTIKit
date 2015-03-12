//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.3
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "UITableView+BTIKitAdditions.h"

// Models and other global
#import "BTIMacros.h"

@implementation UITableView (BTIKitAdditions)

- (NSIndexPath *)indexPathForRowContainingViewBTI:(UIView *)view
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    CGPoint correctedPoint = [view convertPoint:[view bounds].origin toView:self];

    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return [self indexPathForRowAtPoint:correctedPoint];
}

@end
