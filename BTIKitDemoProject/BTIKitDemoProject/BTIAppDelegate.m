//
//  BTIAppDelegate.m
//  BTIKitDemoProject
//
//  Created by Brian Slick on 3/31/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import "BTIAppDelegate.h"

#import "SamplePlainViewController.h"
#import "SampleBasicTableViewController.h"
#import "SampleAdvancedTableViewController.h"

@implementation BTIAppDelegate

#pragma mark - UIApplicationDelegate Methods

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self setWindow:window];
    
    // Note the use of plain alloc/init for the view controllers, courtesy of BTIViewController
    
    SamplePlainViewController *viewController1 = [[SamplePlainViewController alloc] init];
    SampleBasicTableViewController *viewController2 = [[SampleBasicTableViewController alloc] init];
    SampleAdvancedTableViewController *viewController3 = [[SampleAdvancedTableViewController alloc] init];
    
    UINavigationController *navController1 = [[UINavigationController alloc] initWithRootViewController:viewController1];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [self setTabBarController:tabBarController];
    
    [tabBarController setViewControllers:@[ navController1, viewController2, viewController3 ]];
    
    [window setRootViewController:tabBarController];
    [window makeKeyAndVisible];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return YES;
}

@end
