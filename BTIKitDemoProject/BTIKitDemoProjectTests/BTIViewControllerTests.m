//
//  BTIViewControllerTests.m
//  BTIKitDemoProject
//
//  Created by Brian Slick on 4/3/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BTIViewController.h"
#import "BTINotificationInfo.h"

#define kTestVisibleNotification            @"com.briterideas.testVisibleNotification"
#define kTestLifetimeNotification           @"com.briterideas.testLifetimeNotification"

@interface BTIViewControllerTests : XCTestCase

@property (nonatomic, strong) BTIViewController *viewController;

@property (nonatomic, assign, getter = isVisibleNotificationReceived) BOOL visibleNotificationReceived;
@property (nonatomic, assign, getter = isLifetimeNotificationReceived) BOOL lifetimeNotificationReceived;

@end

@implementation BTIViewControllerTests

- (void)setUp
{
    [super setUp];
    
    [self setVisibleNotificationReceived:NO];
    [self setLifetimeNotificationReceived:NO];
    
    BTIViewController *viewController = [[BTIViewController alloc] init];
    [self setViewController:viewController];
    
    BTINotificationInfo *visibleInfo = [BTINotificationInfo infoWithObserver:self
                                                                    selector:@selector(didReceiveVisibleNotification:)
                                                                        name:kTestVisibleNotification
                                                                      object:nil
                                                                    lifespan:BTINotificationInfoLifespanVisible];
    [viewController addNotificationInfo:visibleInfo];
    
    BTINotificationInfo *lifetimeInfo = [BTINotificationInfo infoWithObserver:self
                                                                     selector:@selector(didReceiveLifetimeNotification:)
                                                                         name:kTestLifetimeNotification
                                                                       object:nil
                                                                     lifespan:BTINotificationInfoLifespanLifetime];
    [viewController addNotificationInfo:lifetimeInfo];
    
    [viewController startListeningForNotificationsWithLifespan:BTINotificationInfoLifespanLifetime];
}

- (void)tearDown
{
    BTIViewController *viewController = [self viewController];
    
    [viewController stopListeningForNotificationsWithLifespan:BTINotificationInfoLifespanVisible];
    [viewController stopListeningForNotificationsWithLifespan:BTINotificationInfoLifespanLifetime];
    
    [super tearDown];
}

- (void)testLifetimeNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kTestLifetimeNotification object:nil];
    
    XCTAssertTrue([self isLifetimeNotificationReceived], @"Should have received notification");
    XCTAssertFalse([self isVisibleNotificationReceived], @"Should not have received notification");
}

- (void)testVisibleNotificationBeforeOnScreen
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kTestVisibleNotification object:nil];
    
    XCTAssertFalse([self isLifetimeNotificationReceived], @"Should not have received notification");
    XCTAssertFalse([self isVisibleNotificationReceived], @"Should not have received notification");
}

- (void)testVisibleNotificationWhileOnScreen
{
    BTIViewController *viewController = [self viewController];
    
    [viewController viewWillAppear:NO];
    [viewController viewDidAppear:NO];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kTestVisibleNotification object:nil];

    XCTAssertFalse([self isLifetimeNotificationReceived], @"Should not have received notification");
    XCTAssertTrue([self isVisibleNotificationReceived], @"Should have received notification");
}

- (void)testVisibleNotificationAfterRemovedFromScreen
{
    BTIViewController *viewController = [self viewController];
    
    [viewController viewWillAppear:NO];
    [viewController viewDidAppear:NO];
    
    [viewController viewWillDisappear:NO];
    [viewController viewDidDisappear:NO];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kTestVisibleNotification object:nil];
    
    XCTAssertFalse([self isLifetimeNotificationReceived], @"Should not have received notification");
    XCTAssertFalse([self isVisibleNotificationReceived], @"Should not have received notification");
}

#pragma mark - Notification Handlers

- (void)didReceiveVisibleNotification:(NSNotification *)notification
{
    [self setVisibleNotificationReceived:YES];
}

- (void)didReceiveLifetimeNotification:(NSNotification *)notification
{
    [self setLifetimeNotificationReceived:YES];
}


@end
