//
//  SampleBasicTableViewController.m
//  BTIKitDemoProject
//
//  Created by Brian Slick.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import "SampleBasicTableViewController.h"

// Libraries

// Other Global
#import "Constants.h"
#import "BTIMacros.h"
#import "BTIAlertManager.h"

// Categories
#import "NSNotificationCenter+BTIKitAdditions.h"

// Models

// View Controllers

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

- (void)viewDidLoad
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    [super viewDidLoad];
    
    [self setSearchInterfaceVisible:YES];

    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

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

    [self addLifetimeNotificationInfoForName:BTILifetimeNotification
                                    selector:@selector(doSomethingForLifetimeNotification:)];
    
    [self addVisibleNotificationInfoForName:BTIVisibleNotification
                                   selector:@selector(doSomethingForVisibleNotification:)];
    
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

- (void)handleSearchForTerm:(NSString *)searchTerm
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    [super handleSearchForTerm:searchTerm];
    
    [[self searchContents] removeAllObjects];
    
    for (NSString *string in [self mainContents])
    {
        if ([string rangeOfString:searchTerm options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            [[self searchContents] addObject:string];
        }
    }

    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Notification Handlers

- (void)doSomethingForVisibleNotification:(NSNotification *)notification
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSArray *viewControllers = [[self tabBarController] viewControllers];
    NSInteger index = [viewControllers indexOfObject:self];
    
    BTIAlertOperation *alert = [[BTIAlertOperation alloc] initWithPresentationContext:nil];
    [alert setTitle:[NSString stringWithFormat:@"Tab at index %ld", (long)index]];
    [alert setMessage:@"Received *visible* notification"];
    
    [[BTIAlertManager sharedManager] addAlertOperation:alert];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)doSomethingForLifetimeNotification:(NSNotification *)notification
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSArray *viewControllers = [[self tabBarController] viewControllers];
    NSInteger index = [viewControllers indexOfObject:self];
    
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
