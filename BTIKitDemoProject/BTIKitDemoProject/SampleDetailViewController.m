//
//  SampleDetailViewController.m
//  BTIKitDemoProject
//
//  Created by Brian Slick.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import "SampleDetailViewController.h"

// Libraries

// Other Global
#import "BTIMacros.h"

// Categories
#import "NSNotificationCenter+BTIKitAdditions.h"

// Models

// View Controllers

// Views

// Private Constants
#define kCustomNotification                @"com.briterideas.kCustomNotification"

@interface SampleDetailViewController ()

//Private Properties

@end

@implementation SampleDetailViewController

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
        [self setTitle:@"Details"];
        [self setHidesBottomBarWhenPushed:YES];
    }
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return self;
}

#pragma mark - Custom Getters and Setters


#pragma mark - UIViewController Overrides


#pragma mark - BTIViewController Overrides

- (void)populateNotificationInfos
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [super populateNotificationInfos];
    
    [self addVisibleNotificationInfoForName:kCustomNotification
                                     object:nil
                                 usingBlock:^(NSNotification *notification) {
                                     
                                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Block Notification"
                                                                                     message:@"Received"
                                                                                    delegate:nil
                                                                           cancelButtonTitle:@"Ok"
                                                                           otherButtonTitles:nil];
                                     [alert show];
                                     
                                 }];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Notification Handlers


#pragma mark - UI Response Methods

- (IBAction)notifyButtonPressed:(UIButton *)button
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    // It would be on the main thread anyway, but I need a reason to use this...
    [[NSNotificationCenter defaultCenter] postNotificationNameOnMainThreadBTI:kCustomNotification];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Misc Methods

@end
