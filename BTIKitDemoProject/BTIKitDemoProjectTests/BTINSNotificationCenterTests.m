//
//  BTINSNotificationCenterTests.m
//  BTIKitDemoProject
//
//  Created by Brian Slick on 4/2/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSNotificationCenter+BTIKitAdditions.h"

#define kMainThreadTestNotification     @"com.briterideas.mainThreadTestNotification"

@interface BTINSNotificationCenterTests : XCTestCase

@property (atomic, assign, getter = isNotificationReceived) BOOL notificationReceived;
@property (atomic, assign, getter = isNotificationPostedOnMainThread) BOOL notificationPostedOnMainThread;

@end

@implementation BTINSNotificationCenterTests

- (void)setUp
{
    [super setUp];
    
    [self setNotificationReceived:NO];
    [self setNotificationPostedOnMainThread:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveNotificationForThreadTest:)
                                                 name:kMainThreadTestNotification
                                               object:nil];
}

- (void)tearDown
{
    [super tearDown];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kMainThreadTestNotification
                                                  object:nil];
}

#pragma mark - Asynchronous Test Handling
// http://mentalfaculty.tumblr.com/post/83814421929/unit-testing-asynchronous-cocoa

- (void)waitForAsynchronousTask
{
    CFRunLoopRun();
}

- (void)completeAsynchronousTask
{
    CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)testThatNotificationsArePostedOnMainThreadFromMainThread
{
    [[NSNotificationCenter defaultCenter] postNotificationNameOnMainThreadBTI:kMainThreadTestNotification];
    
    XCTAssertTrue([self isNotificationReceived], @"Notification should have been received");
    XCTAssertTrue([self isNotificationPostedOnMainThread], @"Notification should have been received on main thread");
}

- (void)testThatNotificationsArePostedOnMainThreadFromBackgroundThread
{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {

        [[NSNotificationCenter defaultCenter] postNotificationNameOnMainThreadBTI:kMainThreadTestNotification];

    });
    
    [self waitForAsynchronousTask];
        
    XCTAssertTrue([self isNotificationReceived], @"Notification should have been received");
    XCTAssertTrue([self isNotificationPostedOnMainThread], @"Notification should have been received on main thread");
}

#pragma mark - Notification Handlers

- (void)didReceiveNotificationForThreadTest:(NSNotification *)notification
{
    [self setNotificationPostedOnMainThread:[NSThread isMainThread]];
    [self setNotificationReceived:YES];
    
    [self completeAsynchronousTask];
}

@end
