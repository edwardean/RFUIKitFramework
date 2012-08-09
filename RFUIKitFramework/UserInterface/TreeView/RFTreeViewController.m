//
//  RFTreeViewController.m
//  RFUIKitFramework
//
//  Created by Roman Oliichuk on 02/08/2012.
//  Copyright (c) 2012 Oliromole. All rights reserved.
//

#import "RFTreeViewController.h"

#import "REExtendedUIKit.h"

@interface RFTreeViewController ()

@end

@implementation RFTreeViewController

#pragma mark - Initializing and Creating a RFTreeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        self.title = @"Tree View";
    }
    
    return self;
}

#pragma mark - Deallocating a RFTreeViewController

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

- (RFUITreeView *)treeView
{
    RFUIKeyboardLayoutView *keyboardLayoutView = self.keyboardLayoutView;
    RFUITreeView *treeView = (RFUITreeView *)keyboardLayoutView.contentView;
    return treeView;
}

- (void)loadView
{
    CGRect treeViewFrame;
    treeViewFrame.origin = CGPointZero;
    treeViewFrame.size = [UIScreen mainScreen].bounds.size;
    
    RFUITreeView *treeView = [RFUITreeView viewWithFrame:treeViewFrame];
    treeView.dataSource = self;
    treeView.delegate = self;
    
    CGRect keyboardLayoutViewFrame;
    keyboardLayoutViewFrame.origin = CGPointZero;
    keyboardLayoutViewFrame.size = [UIScreen mainScreen].bounds.size;
    
    RFUIKeyboardLayoutView *keyboardLayoutView = [RFUIKeyboardLayoutView viewWithFrame:keyboardLayoutViewFrame];
    keyboardLayoutView.contentView = treeView;
    
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

#pragma mark - Conforming the RFUITreeViewDataSource Protocol

- (NSInteger)numberOfRowsInRootInTreeView:(RFUITreeView *)treeView
{
    if (treeView && self.isViewLoaded && (treeView == self.treeView))
    {
        return 0;
    }
    
    return 0;
}

- (NSInteger)treeView:(RFUITreeView *)treeView numberOfRowsInParentRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (treeView && self.isViewLoaded && (treeView == self.treeView))
    {
        return 0;
    }
    
    return 0;
}

- (BOOL)treeView:(RFUITreeView *)treeView expandedRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (treeView && self.isViewLoaded && (treeView == self.treeView))
    {
        return NO;
    }
    
    return NO;
}

- (RFUITreeViewCell *)treeView:(RFUITreeView *)treeView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (treeView && self.isViewLoaded && (treeView == self.treeView))
    {
        return NO;
    }
    
    return [RFUITreeViewCell treeViewCellWithReuseIdentifier:nil];
}

#pragma mark - Conforming the RFUITreeViewDelegate Protocol

#pragma mark  Variable height support

- (CGFloat)treeView:(RFUITreeView *)treeView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (treeView && self.isViewLoaded && (treeView == self.treeView))
    {
        return 44.0f;
    }
    
    return (treeView ? treeView.rowHeight : 44.0f);
}

@end
