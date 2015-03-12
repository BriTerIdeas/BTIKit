//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.3
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "UIViewController+BTIKitAdditions.h"

// Models and other global
#import "BTIMacros.h"

@implementation UIViewController (BTIKitAdditions)

- (void)setBackBarButtonTitleBTI:(NSString *)title
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:title
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:nil
                                                                  action:nil];
    [[self navigationItem] setBackBarButtonItem:backButton];

    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

@end
