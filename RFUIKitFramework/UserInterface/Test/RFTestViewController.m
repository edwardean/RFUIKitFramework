//
//  RFTestViewController.m
//  RFUIKitFramework
//
//  Created by Roman Oliichuk on 02/08/2012.
//  Copyright (c) 2012 Oliromole. All rights reserved.
//

#import "RFTestViewController.h"

#import "REExtendedUIKit.h"

@interface RFTestViewController ()

@end

@implementation RFTestViewController

#pragma mark - Initializing and Creating a RFTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
    }

    return self;
}

#pragma mark - Deallocating a RFTestViewController

- (void)dealloc
{
    [super dealloc];
}

#pragma mark - Managing the View

- (RFUIKeyboardLayoutView *)keyboardLayoutView
{
    RFUIKeyboardLayoutView *keyboardLayoutView = (RFUIKeyboardLayoutView *)self.view;
    return keyboardLayoutView;
}

- (RFTestView *)testView
{
    RFUIKeyboardLayoutView *keyboardLayoutView = self.keyboardLayoutView;
    RFTestView *testView = (RFTestView *)keyboardLayoutView.contentView;
    return testView;
}

- (void)loadView
{
    CGRect testViewFrame;
    testViewFrame.origin = CGPointZero;
    testViewFrame.size = [UIScreen mainScreen].bounds.size;
    
    RFTestView *testView = [RFTestView viewWithFrame:testViewFrame];
    
    CGRect keyboardLayoutViewFrame;
    keyboardLayoutViewFrame.origin = CGPointZero;
    keyboardLayoutViewFrame.size = [UIScreen mainScreen].bounds.size;
    
    RFUIKeyboardLayoutView *keyboardLayoutView = [RFUIKeyboardLayoutView viewWithFrame:keyboardLayoutViewFrame];
    keyboardLayoutView.contentView = testView;
    
    self.view = keyboardLayoutView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma mark - Handling Memory Warnings

- (void)didReceiveMemoryWarning
{
    //[super didReceiveMemoryWarning];
}

#pragma mark - Configuring the View Rotation Settings

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Responding to View Events

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

@end
