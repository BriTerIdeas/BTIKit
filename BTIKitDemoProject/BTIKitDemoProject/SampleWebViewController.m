//
//  SampleWebViewController.m
//  BTIKitDemoProject
//
//  Created by Brian Slick on 8/16/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import "SampleWebViewController.h"

// Libraries

// Other Global
#import "BTIMacros.h"

// Categories
#import "NSArray+BTIKitAdditions.h"

// Models

// View Controllers

// Views

// Private Constants

@interface SampleWebViewController ()

//Private Properties
@property (nonatomic, strong) NSArray *urls;

@end

@implementation SampleWebViewController

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
        [self setHidesBottomBarWhenPushed:YES];
    }
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return self;
}

#pragma mark - Custom Getters and Setters

- (NSArray *)urls
{
    if (_urls == nil)
    {
        _urls = [[NSArray alloc] initWithObjects:
                 [NSURL URLWithString:@"http://www.google.com/"],
                 [NSURL URLWithString:@"http://www.apple.com/"],
                 [NSURL URLWithString:@"http://www.amazon.com/"],
                 [NSURL URLWithString:@"http://www.yahoo.com/"],
                 nil];
    }
    return _urls;
}

#pragma mark - UIViewController Overrides

- (void)viewDidLoad
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    [super viewDidLoad];
    
    [self setTitle:@"Web View"];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self setActivityIndicatorView:activityIndicator];
    [activityIndicator setHidesWhenStopped:YES];
    
    UIBarButtonItem *activityButton = [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
    
    UIBarButtonItem *loadButton = [[UIBarButtonItem alloc] initWithTitle:@"Load"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(loadButtonPressed:)];
    
    [[self navigationItem] setRightBarButtonItems:@[ loadButton, activityButton ]];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)viewWillAppear:(BOOL)animated
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    [super viewWillAppear:animated];
    
    [self loadButtonPressed:nil];

    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - BTIViewController Overrides


#pragma mark - Notification Handlers


#pragma mark - UI Response Methods

- (void)loadButtonPressed:(UIBarButtonItem *)button
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSURL *url = [[self urls] objectAtRandomIndexBTI];
    
    [self loadURL:url];

    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Misc Methods

@end
