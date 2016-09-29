//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.6
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "UITableViewCell+BTIKitAdditions.h"

// Libraries

// Other Global
#import "BTIMacros.h"

// Categories
#import "UIView+BTIKitAdditions.h"

// Models

// Private Constants

@implementation UITableViewCell (BTIKitAdditions)

- (UITableView *)enclosingTableViewBTI
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    UITableView *tableView = nil;
    UIView *view = self;
    while (view != nil)
    {
        if ([view isKindOfClass:[UITableView class]])
        {
            tableView = (UITableView *)view;
            break;
        }
        view = [view superview];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return tableView;
}

+ (instancetype)cellFromNibNameBTI:(NSString *)nibNameOrNil
{
    return [[self class] viewFromNibNameBTI:nibNameOrNil];
}

+ (instancetype)cellFromNibBTI;
{
    return [[self class] cellFromNibNameBTI:NSStringFromClass([self class])];
}

@end
