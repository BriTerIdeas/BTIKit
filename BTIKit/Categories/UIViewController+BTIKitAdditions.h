//
//  UIViewController+BTIKitAdditions.h
//  BTIKit
//  v1.1
//
//  Created by Brian Slick in August 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (BTIKitAdditions)

/**
 Creates a UIBarButtonItem with the provided title and sets it as the back button item
 
 @param title The title that should appear in the back button
 */
- (void)setBackBarButtonTitleBTI:(NSString *)title;

@end
