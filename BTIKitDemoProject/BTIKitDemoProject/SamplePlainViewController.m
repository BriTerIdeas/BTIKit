//
//  SamplePlainViewController.m
//  BTIKitDemoProject
//
//  Created by Brian Slick.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import "SamplePlainViewController.h"

// Libraries

// Other Global
#import "Constants.h"
#import "BTIMacros.h"
#import "BTIAlertManager.h"

// Categories
#import "NSNotificationCenter+BTIKitAdditions.h"
#import "UIViewController+BTIKitAdditions.h"

// Models

// View Controllers
#import "SampleDetailViewController.h"
#import "SampleWebViewController.h"

// Views

// Private Constants

@interface SamplePlainViewController ()

//Private Properties

@end

@implementation SamplePlainViewController

#pragma mark - Synthesized Properties


#pragma mark - Dealloc and Memory Methods


#pragma mark - Initialization and UI Creation Methods

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self)
    {
        [self setTitle:@"Plain"];
        [[self tabBarItem] setImage:[UIImage imageNamed:@"first"]];
    }
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return self;
}

#pragma mark - Custom Getters and Setters


#pragma mark - UIViewController Overrides

- (void)viewWillAppear:(BOOL)animated
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    [super viewWillAppear:animated];
    
    [self setBackBarButtonTitleBTI:@"Bork"];
    
    NSLog(@"This log will appear in Debug and Debug_and_Tracking. If it shows up in Release, something is wrong");

    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - BTIViewController Overrides

- (void)populateNotificationInfos
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [super populateNotificationInfos];
    
    [self addLifetimeNotificationInfoForName:BTILifetimeNotification
                                    selector:@selector(doSomethingForLifetimeNotification:)];
    
    [self addVisibleNotificationInfoForName:BTIVisibleNotification
                                   selector:@selector(doSomethingForVisibleNotification:)];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Notification Handlers

- (void)doSomethingForVisibleNotification:(NSNotification *)notification
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSInteger index = [self currentTabBarControllerIndex];
    
    BTIAlertOperation *alert = [[BTIAlertOperation alloc] initWithPresentationContext:nil];
    [alert setTitle:[NSString stringWithFormat:@"Tab at index %ld", (long)index]];
    [alert setMessage:@"Received *visible* notification"];
    
    [[BTIAlertManager sharedManager] addAlertOperation:alert];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)doSomethingForLifetimeNotification:(NSNotification *)notification
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSInteger index = [self currentTabBarControllerIndex];
    
    BTIAlertOperation *alert = [[BTIAlertOperation alloc] initWithPresentationContext:nil];
    [alert setTitle:[NSString stringWithFormat:@"Tab at index %ld", (long)index]];
    [alert setMessage:@"Received *lifetime* notification"];
    
    [[BTIAlertManager sharedManager] addAlertOperation:alert];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - UI Response Methods

- (IBAction)visibleButtonPressed:(UIButton *)button
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    // It would be on the main thread anyway, but I need a reason to use this...
    [[NSNotificationCenter defaultCenter] postNotificationNameOnMainThreadBTI:BTIVisibleNotification];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (IBAction)lifetimeButtonPressed:(UIButton *)button
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    // It would be on the main thread anyway, but I need a reason to use this...
    [[NSNotificationCenter defaultCenter] postNotificationNameOnMainThreadBTI:BTILifetimeNotification];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (IBAction)detailButtonPressed:(UIButton *)button
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    SampleDetailViewController *detailViewController = [[SampleDetailViewController alloc] init];
    
    [[self navigationController] pushViewController:detailViewController animated:YES];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (IBAction)webButtonPressed:(UIButton *)button
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    SampleWebViewController *webViewController = [[SampleWebViewController alloc] init];
    
    [[self navigationController] pushViewController:webViewController animated:YES];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Misc Methods

- (NSInteger)currentTabBarControllerIndex
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    NSArray *viewControllers = [[self tabBarController] viewControllers];
    NSInteger index = [viewControllers indexOfObject:self];
    
    if (index == NSNotFound)
    {
        index = 0;
        for (UIViewController *viewController in viewControllers)
        {
            if ([viewController isKindOfClass:[UINavigationController class]])
            {
                UINavigationController *navigationController = (UINavigationController *)viewController;
                
                if ([[navigationController viewControllers] containsObject:self])
                {
                    break;
                }
            }
            index++;
        }
    }
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return index;
}

@end
