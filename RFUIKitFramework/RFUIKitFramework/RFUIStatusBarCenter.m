//
//  RFUIStatusBarCenter.m
//  RFUIKitFramework
//  https://github.com/oliromole/RFUIKitFramework.git
//
//  Created by Roman Oliichuk on 2012.08.08.
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

#import "RFUIStatusBarCenter.h"

NSString * const RFUIStatusBarCenterWillChangeStatusBarFrameNotification = @"RFUIStatusBarCenterWillChangeStatusBarFrameNotification";
NSString * const RFUIStatusBarCenterDidChangeStatusBarFrameNotification = @"RFUIStatusBarCenterDidChangeStatusBarFrameNotification";

NSString * const RFUIStatusBarCenterWillChangeStatusBarOrientationNotification = @"RFUIStatusBarCenterWillChangeStatusBarOrientationNotification";
NSString * const RFUIStatusBarCenterDidChangeStatusBarOrientationNotification = @"RFUIStatusBarCenterDidChangeStatusBarOrientationNotification";

static RFUIStatusBarCenter * RFUIStatusBarCenter_SharedCenter = nil;
static NSObject * RFUIStatusBarCenter_Synchronizer = nil;

@implementation RFUIStatusBarCenter

#pragma mark - Initializing a Class

+ (void)initialize
{
    if (self == [RFUIStatusBarCenter class])
    {
        RFUIStatusBarCenter_SharedCenter = nil;
        RFUIStatusBarCenter_Synchronizer = [[NSObject alloc] init];
    }
}

#pragma mark - Getting the RFUIStatusBarCenter Instance

+ (RFUIStatusBarCenter *)sharedCenter
{
    if (!RFUIStatusBarCenter_SharedCenter)
    {
        @synchronized(RFUIStatusBarCenter_Synchronizer)
        {
            if (!RFUIStatusBarCenter_SharedCenter)
            {
                RFUIStatusBarCenter_SharedCenter = [[RFUIStatusBarCenter alloc] init];
            }
        }
    }
    
    return RFUIStatusBarCenter_SharedCenter;
}

#pragma mark - Initializing and Creating a RFUIStatusBarCenter

- (id)init
{
    if ((self = [super init]))
    {
        mApplication = [[UIApplication sharedApplication] retain];
        
        if (!mApplication)
        {
            @throw [NSException exceptionWithName:NSGenericException reason:@"[UIApplication sharedApplication] returns nil." userInfo:nil];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillChangeStatusBarFrameNotification:) name:UIApplicationWillChangeStatusBarFrameNotification object:mApplication];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidChangeStatusBarFrameNotification:) name:UIApplicationDidChangeStatusBarFrameNotification object:mApplication];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillChangeStatusBarOrientationNotification:) name:UIApplicationWillChangeStatusBarOrientationNotification object:mApplication];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidChangeStatusBarOrientationNotification:) name:UIApplicationDidChangeStatusBarOrientationNotification object:mApplication];
    }
    
    return self;
}

#pragma mark - Deallocating a RFUIStatusBarCenter

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [mApplication release];
    mApplication = nil;
    
    [super dealloc];
}

#pragma mark - Managing the Status Bar

- (UIStatusBarStyle)statusBarStyle
{
    UIStatusBarStyle statusBarStyle = mApplication.statusBarStyle;
    return statusBarStyle;
}

- (void)setStatusBarStyle:(UIStatusBarStyle)newStatusBarStyle
{
    UIStatusBarStyle oldStatusBarStyle = mApplication.statusBarStyle;
    
    if (oldStatusBarStyle != newStatusBarStyle)
    {
        mApplication.statusBarStyle = newStatusBarStyle;
    }
}

- (void)setStatusBarStyle:(UIStatusBarStyle)newStatusBarStyle animated:(BOOL)animated
{
    UIStatusBarStyle oldStatusBarStyle = mApplication.statusBarStyle;
    
    if (oldStatusBarStyle != newStatusBarStyle)
    {
        [mApplication setStatusBarStyle:newStatusBarStyle animated:animated];
    }
}

- (BOOL)statusBarHidden
{
    BOOL statusBarHidden = mApplication.statusBarHidden;
    return statusBarHidden;
}

- (void)setStatusBarHidden:(BOOL)newStatusBarHidden
{
    BOOL oldStatusBarHidden = mApplication.statusBarHidden;
    
    if (oldStatusBarHidden != newStatusBarHidden)
    {
        mApplication.statusBarHidden = newStatusBarHidden;
    }
}

- (void)setStatusBarHidden:(BOOL)newStatusBarHidden withAnimation:(UIStatusBarAnimation)animation
{
    BOOL oldStatusBarHidden = mApplication.statusBarHidden;
    
    if (oldStatusBarHidden != newStatusBarHidden)
    {
        [mApplication setStatusBarHidden:newStatusBarHidden withAnimation:animation];
    }
}

- (UIInterfaceOrientation)statusBarOrientation
{
    UIInterfaceOrientation statusBarOrientation = mApplication.statusBarOrientation;
    return statusBarOrientation;
}

- (void)setStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation
{
    UIInterfaceOrientation oldStatusBarOrientation = mApplication.statusBarOrientation;
    
    if (oldStatusBarOrientation != newStatusBarOrientation)
    {
        mApplication.statusBarOrientation = newStatusBarOrientation;
    }
}

- (void)setStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation animated:(BOOL)animated
{
    UIInterfaceOrientation oldStatusBarOrientation = mApplication.statusBarOrientation;
    
    if (oldStatusBarOrientation != newStatusBarOrientation)
    {
        [mApplication setStatusBarOrientation:newStatusBarOrientation animated:animated];
    }
}

- (NSTimeInterval)statusBarOrientationAnimationDuration
{
    NSTimeInterval statusBarOrientationAnimationDuration = mApplication.statusBarOrientationAnimationDuration;
    return statusBarOrientationAnimationDuration;
}

- (CGRect)statusBarFrame
{
    CGRect statusBarFrame = mApplication.statusBarFrame;
    return statusBarFrame;
}

#pragma mark - Notifications

#pragma mark UIApplication Notifications

- (void)applicationWillChangeStatusBarFrameNotification:(NSNotification *)notification
{
    if (notification &&
        notification.object &&
        (notification.object == mApplication) &&
        notification.name &&
        [notification.name isEqual:UIApplicationWillChangeStatusBarFrameNotification])
    {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:RFUIStatusBarCenterWillChangeStatusBarFrameNotification object:self userInfo:nil];
    }
}

- (void)applicationDidChangeStatusBarFrameNotification:(NSNotification *)notification
{
    if (notification &&
        notification.object &&
        (notification.object == mApplication) &&
        notification.name &&
        [notification.name isEqual:UIApplicationDidChangeStatusBarFrameNotification])
    {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:RFUIStatusBarCenterDidChangeStatusBarFrameNotification object:self userInfo:nil];
    }
}

- (void)applicationWillChangeStatusBarOrientationNotification:(NSNotification *)notification
{
    if (notification &&
        notification.object &&
        (notification.object == mApplication) &&
        notification.name &&
        [notification.name isEqual:UIApplicationWillChangeStatusBarOrientationNotification])
    {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:RFUIStatusBarCenterWillChangeStatusBarOrientationNotification object:self userInfo:nil];
    }
}

- (void)applicationDidChangeStatusBarOrientationNotification:(NSNotification *)notification
{
    if (notification &&
        notification.object &&
        (notification.object == mApplication) &&
        notification.name &&
        [notification.name isEqual:UIApplicationDidChangeStatusBarOrientationNotification])
    {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:RFUIStatusBarCenterDidChangeStatusBarOrientationNotification object:self userInfo:nil];
    }
}

@end
