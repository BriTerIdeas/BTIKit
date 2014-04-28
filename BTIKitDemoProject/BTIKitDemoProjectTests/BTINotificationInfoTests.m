//
//  BTINotificationInfoTests.m
//  BTIKitDemoProject
//
//  Created by Brian Slick on 4/2/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BTINotificationInfo.h"

#define kTestNotification     @"kTestNotification"

@interface BTINotificationInfoTests : XCTestCase

@property (nonatomic, strong) BTINotificationInfo *notificationInfo;
@property (atomic, assign, getter = isNotificationReceived) BOOL notificationReceived;

@end

@implementation BTINotificationInfoTests

- (void)setUp
{
    [super setUp];
    
    [self setNotificationReceived:NO];
}

- (void)tearDown
{
    [super tearDown];
}

#pragma mark - Standard Notification Tests

- (void)setUpStandardNotificationScenario
{
    BTINotificationInfo *notificationInfo = [BTINotificationInfo infoWithObserver:self
                                                                         selector:@selector(didReceiveNotification:)
                                                                             name:kTestNotification
                                                                           object:nil
                                                                         lifespan:BTINotificationInfoLifespanCustom];
    [self setNotificationInfo:notificationInfo];
}

- (void)testThatObserverIsRequired
{
    BTINotificationInfo *notificationInfo = [BTINotificationInfo infoWithObserver:nil
                                                                         selector:@selector(setUp)
                                                                             name:@"Does Not Matter"
                                                                           object:nil
                                                                         lifespan:BTINotificationInfoLifespanCustom];
    
    XCTAssertNil(notificationInfo, @"Should not have been able to create info without an observer");
}

- (void)testThatSelectorIsRequired
{
    BTINotificationInfo *notificationInfo = [BTINotificationInfo infoWithObserver:self
                                                                         selector:nil
                                                                             name:@"Does Not Matter"
                                                                           object:nil
                                                                         lifespan:BTINotificationInfoLifespanCustom];
    
    XCTAssertNil(notificationInfo, @"Should not have been able to create info without a selector");
}

- (void)testThatNothingHappensBeforeListeningStarts
{
    [self setUpStandardNotificationScenario];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kTestNotification object:nil];
    
    XCTAssertFalse([self isNotificationReceived], @"Should not have received a notification");
}

- (void)testThatListeningStarts
{
    [self setUpStandardNotificationScenario];

    [[self notificationInfo] startListening];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kTestNotification object:nil];
    
    XCTAssertTrue([self isNotificationReceived], @"Should have received a notification");
}

- (void)testThatListeningStops
{
    [self setUpStandardNotificationScenario];

    [[self notificationInfo] startListening];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kTestNotification object:nil];
    
    [self setNotificationReceived:NO];
    
    [[self notificationInfo] stopListening];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kTestNotification object:nil];
    
    XCTAssertFalse([self isNotificationReceived], @"Should not have received a notification");
}

#pragma mark - Block Notification Tests

- (void)setUpBlockNotificationScenario
{
    __weak BTINotificationInfoTests *weakSelf = self;
    
    BTINotificationInfo *notificationInfo = [BTINotificationInfo infoWithName:kTestNotification
                                                                       object:nil
                                                                     lifespan:BTINotificationInfoLifespanCustom
                                                                   usingBlock:^(NSNotification *notification) {
                                                                       
                                                                       [weakSelf setNotificationReceived:YES];
                                                                       
                                                                   }];
    [self setNotificationInfo:notificationInfo];
}

- (void)testThatBlockIsRequired
{
    BTINotificationInfo *notificationInfo = [BTINotificationInfo infoWithName:kTestNotification
                                                                       object:nil
                                                                     lifespan:BTINotificationInfoLifespanCustom
                                                                   usingBlock:nil];
    
    XCTAssertNil(notificationInfo, @"Should not have been able to create info without a block");
}

- (void)testThatNothingHappensBeforeBlockListeningStarts
{
    [self setUpBlockNotificationScenario];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kTestNotification object:nil];
    
    XCTAssertFalse([self isNotificationReceived], @"Should not have received a notification");
}

- (void)testThatBlockListeningStarts
{
    [self setUpBlockNotificationScenario];
    
    [[self notificationInfo] startListening];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kTestNotification object:nil];
    
    XCTAssertTrue([self isNotificationReceived], @"Should have received a notification");
}

- (void)testThatBlockListeningStops
{
    [self setUpBlockNotificationScenario];
    
    [[self notificationInfo] startListening];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kTestNotification object:nil];
    
    [self setNotificationReceived:NO];
    
    [[self notificationInfo] stopListening];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kTestNotification object:nil];
    
    XCTAssertFalse([self isNotificationReceived], @"Should not have received a notification");
}

#pragma mark - Notification Handlers

- (void)didReceiveNotification:(NSNotification *)notification
{
    [self setNotificationReceived:YES];
}

@end
