//
//  SampleBasicTableViewController.m
//  BTIKitDemoProject
//
//  Created by Brian Slick.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import "SampleBasicTableViewController.h"

// Models and other global
#import "Constants.h"
#import "BTIKit.h"

// Sub-controllers

// Views
#import "SampleTableViewCell1.h"
#import "SampleTableHeaderFooterView.h"

// Private Constants

@interface SampleBasicTableViewController ()

//Private Properties

@end

@implementation SampleBasicTableViewController

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
        [self setTitle:@"Simple Table"];
        [[self tabBarItem] setImage:[UIImage imageNamed:@"second"]];
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
    
    [self populateContents];
    
    UITableView *tableView = [self tableView];
    
    UIEdgeInsets edgeInsets = [tableView contentInset];
    edgeInsets.bottom = [[self bottomLayoutGuide] length];
    [tableView setContentInset:edgeInsets];
    [tableView setScrollIndicatorInsets:edgeInsets];
    
    [tableView reloadData];

    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - BTIViewController Overrides

- (void)populateContents
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSMutableArray *contents = [self mainContents];
    
    [contents removeAllObjects];
    
    [contents addObject:@"Red"];
    [contents addObject:@"Orange"];
    [contents addObject:@"Yellow"];
    [contents addObject:@"Green"];
    [contents addObject:@"Blue"];
    [contents addObject:@"Indigo"];
    [contents addObject:@"Violet"];
    
    [[self tableView] reloadData];

    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)populateNotificationInfos
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [super populateNotificationInfos];

    [self addLifetimeNotificationInfoForName:kLifetimeNotification
                                    selector:@selector(doSomethingForLifetimeNotification:)
                                      object:nil];
    
    [self addVisibleNotificationInfoForName:kVisibleNotification
                                   selector:@selector(doSomethingForVisibleNotification:)
                                     object:nil];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - BTITableViewController Overrides

- (void)registerNibsForTableView:(UITableView *)tableView
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    [SampleTableViewCell1 registerNibForTableViewBTI:tableView];
    
    SampleTableViewCell1 *cell = [SampleTableViewCell1 dequeueCellFromTableViewBTI:tableView];
    [tableView setRowHeight:CGRectGetHeight([cell frame])];

    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Notification Handlers

- (void)doSomethingForVisibleNotification:(NSNotification *)notification
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSArray *viewControllers = [[self tabBarController] viewControllers];
    NSInteger index = [viewControllers indexOfObject:self];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Tab at index %ld\n", (long)index]
                                                    message:@"Received *visible* notification"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)doSomethingForLifetimeNotification:(NSNotification *)notification
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSArray *viewControllers = [[self tabBarController] viewControllers];
    NSInteger index = [viewControllers indexOfObject:self];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Tab at index %ld\n", (long)index]
                                                    message:@"Received *lifetime* notification"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - UI Response Methods

- (IBAction)visibleButtonPressed:(UIButton *)button
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    // It would be on the main thread anyway, but I need a reason to use this...
    [[NSNotificationCenter defaultCenter] postNotificationNameOnMainThreadBTI:kVisibleNotification];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (IBAction)lifetimeButtonPressed:(UIButton *)button
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    // It would be on the main thread anyway, but I need a reason to use this...
    [[NSNotificationCenter defaultCenter] postNotificationNameOnMainThreadBTI:kLifetimeNotification];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Misc Methods


#pragma mark - UITableViewDataSource Methods

// Superclass handles basic cases.  Override the usual methods for customization.

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    SampleTableViewCell1 *cell = [SampleTableViewCell1 dequeueCellFromTableViewBTI:tableView];
    
    NSString *text = [self itemInTableView:tableView atIndexPath:indexPath];
    
    [[cell verificationLabel] setText:text];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

@end
