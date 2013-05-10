//
//  RFUILayoutContainerWrapperView.m
//  RFUIKitFramework
//  https://github.com/oliromole/RFUIKitFramework.git
//
//  Created by Roman Oliichuk on 2013.05.07.
//  Copyright (c) 2012 Roman Oliichuk. All rights reserved.
//

/*
 Copyright (C) 2012 Roman Oliichuk. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:
 
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 
 * Neither the name of the author nor the names of its contributors
 may be used to endorse or promote products derived from this
 software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "RFUILayoutContainerWrapperView.h"

#import "REExtendedUIKit.h"

#import "RFUIStatusBarCenter.h"

@implementation RFUILayoutContainerWrapperView

#pragma mark - Initializing and Creating a RFUILayoutContainerWrapperView

- (id)initWithFrame:(CGRect)viewFrame
{
    if ((self = [super initWithFrame:viewFrame]))
    {
        // Getting the default notification center.
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        
        // Registering itself as an observer of notifications from the status bar center.
        RFUIStatusBarCenter *statusBarCenter = [RFUIStatusBarCenter sharedCenter];
        [notificationCenter addObserver:self selector:@selector(statusBarCenterWillChangeStatusBarFrameNotification:) name:RFUIStatusBarCenterWillChangeStatusBarFrameNotification object:statusBarCenter];
        [notificationCenter addObserver:self selector:@selector(statusBarCenterDidChangeStatusBarFrameNotification:) name:RFUIStatusBarCenterDidChangeStatusBarFrameNotification object:statusBarCenter];
        
        // Creating a content view.
        mContentView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, viewFrame.size.width, viewFrame.size.height)];
        
        // Building the view hierarchy.
        [self addSubview:mContentView];
        
        // Configuring the view.
        self.clipsToBounds = YES;
        
        // Laying out own subviews.
        [self layoutSubviewsInRFUILayoutContainerWrapperView];
    }
    
    return self;
}

#pragma mark - Deallocating a RFUILayoutContainerWrapperView

- (void)dealloc
{
    // Removing self as an observer for all notifications.
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self];
    
    mContentView = nil;
}

#pragma mark - Laying out Subviews

- (void)layoutSubviewsInRFUILayoutContainerWrapperView
{
    // Getting the view frame.
    CGRect viewFrame = self.frame;
    
    // Getting the status bar frame.
    RFUIStatusBarCenter *statusBarCenter = [RFUIStatusBarCenter sharedCenter];
    CGRect statusBarFrame = statusBarCenter.frame;
    
    // Declaring some variables.
    CGRect contentViewFrame;
    
    // Calculating the status bar height.
    CGFloat statusBarHeight = MIN(statusBarFrame.size.width, statusBarFrame.size.height);
    
    // Calculating the content view frame.
    contentViewFrame.origin.x = 0.0f;
    contentViewFrame.origin.y = -statusBarHeight;
    contentViewFrame.size.width = viewFrame.size.width;
    contentViewFrame.size.height = viewFrame.size.height + statusBarHeight;
    
    // Applying the calculated frames.
    [mContentView setFrameIfNeeded:contentViewFrame];
    
    // Calculating the subcontent view frame.
    CGRect subcontentViewFrame;
    subcontentViewFrame.origin = CGPointZero;
    subcontentViewFrame.size = contentViewFrame.size;
    
    // Applying the calculated frame for any subcontent views.
    for (UIView *subcontentView in mContentView.subviews)
    {
        // Applying the calculated frame of subcontent view.
        [subcontentView setFrameIfNeeded:subcontentViewFrame];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Laying out own subviews.
    [self layoutSubviewsInRFUILayoutContainerWrapperView];
}

#pragma mark - Accessing the Content View

@synthesize contentView = mContentView;


#pragma mark - Notifications

#pragma mark RFUIStatusBarCenter Notitications

- (void)statusBarCenterWillChangeStatusBarFrameNotification:(NSNotification *)notification
{
    // Get the status bar center.
    RFUIStatusBarCenter *statusBarCenter = [RFUIStatusBarCenter sharedCenter];
    
    // We received the RFUIStatusBarCenterWillChangeStatusBarFrameNotification notification.
    if (NSNotificationEqualToNotificationNameAndObject(notification, RFUIStatusBarCenterWillChangeStatusBarFrameNotification, statusBarCenter))
    {
        // Laying out own subviews.
        [self layoutSubviewsInRFUILayoutContainerWrapperView];
    }
}

- (void)statusBarCenterDidChangeStatusBarFrameNotification:(NSNotification *)notification
{
    // Get the status bar center.
    RFUIStatusBarCenter *statusBarCenter = [RFUIStatusBarCenter sharedCenter];
    
    // We received the RFUIStatusBarCenterDidChangeStatusBarFrameNotification notification.
    if (NSNotificationEqualToNotificationNameAndObject(notification, RFUIStatusBarCenterDidChangeStatusBarFrameNotification, statusBarCenter))
    {
        // Laying out own subviews.
        [self layoutSubviewsInRFUILayoutContainerWrapperView];
    }
}

@end
