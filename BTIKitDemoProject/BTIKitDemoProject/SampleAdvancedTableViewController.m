//
//  SampleAdvancedTableViewController.m
//  BTIKitDemoProject
//
//  Created by Brian Slick.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import "SampleAdvancedTableViewController.h"

// Models and other global
#import "BTIKit.h"

// Sub-controllers

// Views
#import "SampleTableHeaderFooterView.h"

// Private Constants

@interface SampleAdvancedTableViewController ()

//Private Properties

@end

@implementation SampleAdvancedTableViewController

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
        [self setTitle:@"Advanced Table"];
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
    
    // It looks busy, but at least everything is right here.  Otherwise this content would be spread over several methods.  The concept avoids a whole mess of if/else statements in cellForRow, and titleForHeader, and titleForFooter, and didSelectRow, and...
    // This is a contrived example, but the intention is that each block could do something considerably different.  Some could push on a navigation controller, some could present modally, etc.
    
    BTITableContentsManager *manager = [self mainContentsManager];
    [manager reset];
    
    CGFloat standardRowHeight = 50.0;
    CGFloat bonusRowHeight = 75.0;
    
    BTITableSectionInfo *sectionInfo = nil;
    BTITableRowInfo *rowInfo = nil;
    
    {{  // Spaceballs
        sectionInfo = [manager dequeueReusableSectionInfoAndAddToContents];
        [sectionInfo setHeaderTitle:@"GO!"];
        [sectionInfo setFooterTitle:@"They've gone to plaid!"];
        
        rowInfo = [manager dequeueReusableRowInfo];
        [manager addRowInfo:rowInfo makeNewSection:NO];
        
        [rowInfo setText:@"Light"];
        [rowInfo setDetailText:@"1, 2, 3, 4, 5"];
        [rowInfo setImageName:@"first"];
        [rowInfo setCellAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [rowInfo setRowHeight:standardRowHeight];
        [rowInfo setRowSelectionBlock:^{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"I've got the same combination on my luggage!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"That's amazing!"
                                                  otherButtonTitles:nil];
            [alert show];
            
        }];
        
        rowInfo = [manager dequeueReusableRowInfo];
        [manager addRowInfo:rowInfo makeNewSection:NO];
        
        [rowInfo setText:@"Ridiculous"];
        [rowInfo setDetailText:@"That's just what we needed: a Druish princess"];
        [rowInfo setImageName:@"second"];
        [rowInfo setCellAccessoryType:UITableViewCellAccessoryCheckmark];
        [rowInfo setRowHeight:bonusRowHeight];
        [rowInfo setRowSelectionBlock:^{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"Funny. She doesn't look Druish."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Try to save the car..."
                                                  otherButtonTitles:nil];
            [alert show];
            
        }];
        
        rowInfo = [manager dequeueReusableRowInfo];
        [manager addRowInfo:rowInfo makeNewSection:NO];
        
        [rowInfo setText:@"Ludicrous"];
        [rowInfo setDetailText:@"Ah, buckle this"];
        [rowInfo setRowHeight:standardRowHeight];
        [rowInfo setRowSelectionBlock:^{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"My brains are going into my feet!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"What have I done?!"
                                                  otherButtonTitles:nil];
            [alert show];
            
        }];
        
    }}
    
    {{  // Army of Darkness
        sectionInfo = [manager dequeueReusableSectionInfoAndAddToContents];
        [sectionInfo setHeaderTitle:@"Gimmie some sugar, baby"];
        [sectionInfo setFooterTitle:@"Hail to the king, baby"];

        rowInfo = [manager dequeueReusableRowInfo];
        [manager addRowInfo:rowInfo makeNewSection:NO];
        
        [rowInfo setText:@"Klaatu"];
        [rowInfo setRowHeight:standardRowHeight];

        rowInfo = [manager dequeueReusableRowInfo];
        [manager addRowInfo:rowInfo makeNewSection:NO];
        
        [rowInfo setText:@"Barada"];
        [rowInfo setCellAccessoryType:UITableViewCellAccessoryCheckmark];

        rowInfo = [manager dequeueReusableRowInfo];
        [manager addRowInfo:rowInfo makeNewSection:NO];
        
        [rowInfo setText:@"N..."];
        [rowInfo setImageName:@"first"];
        [rowInfo setCellAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
        [rowInfo setRowHeight:bonusRowHeight];
        [rowInfo setRowAccessorySelectionBlock:^{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"Necktie... Neckturn... Nickel..."
                                                           delegate:nil
                                                  cancelButtonTitle:@"It's an \"N\" word"
                                                  otherButtonTitles:nil];
            [alert show];

        }];
        
        rowInfo = [manager dequeueReusableRowInfo];
        [manager addRowInfo:rowInfo makeNewSection:NO];
        
        [rowInfo setText:@"Shop smart"];
        [rowInfo setDetailText:@"Shop S-Mart"];
        [rowInfo setCellAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [rowInfo setRowHeight:standardRowHeight];

    }}
    
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

    [SampleTableHeaderFooterView registerNibForTableViewBTI:tableView];

    SampleTableHeaderFooterView *view = [SampleTableHeaderFooterView dequeueHeaderFooterViewFromTableViewBTI:tableView];
    
    CGFloat headerFooterHeight = CGRectGetHeight([view frame]);
    
    [tableView setSectionHeaderHeight:headerFooterHeight];
    [tableView setSectionFooterHeight:headerFooterHeight];
    
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

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section
{
    SampleTableHeaderFooterView *view = [SampleTableHeaderFooterView dequeueHeaderFooterViewFromTableViewBTI:tableView];
    
    [[view verificationLabel] setText:[[self mainContentsManager] headerTitleInSection:section]];
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    SampleTableHeaderFooterView *view = [SampleTableHeaderFooterView dequeueHeaderFooterViewFromTableViewBTI:tableView];
    
    [[view verificationLabel] setText:[[self mainContentsManager] footerTitleInSection:section]];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self mainContentsManager] heightForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    // Build Cell
    
    static NSString *blankCellIdentifier = @"blankCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:blankCellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:blankCellIdentifier];
    }
    
    // Acquire Data
    
    BTITableRowInfo *rowInfo = [self rowInfoInTableView:tableView atIndexPath:indexPath];
    
    // Populate Cell
    
    [rowInfo populateCell:cell];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BTITableRowInfo *rowInfo = [self rowInfoInTableView:tableView atIndexPath:indexPath];

    [rowInfo safelyPerformRowSelectionBlock];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)tableView:(UITableView *)tableView
accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
        
    BTITableRowInfo *rowInfo = [self rowInfoInTableView:tableView atIndexPath:indexPath];
    
    [rowInfo safelyPerformRowAccessorySelectionBlock];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

@end
