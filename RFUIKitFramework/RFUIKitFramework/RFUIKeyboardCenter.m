//
//  RFUIKeyboardCenter.m
//  RFUIKitFramework
//  https://github.com/oliromole/RFUIKitFramework.git
//
//  Created by Roman Oliichuk on 2011.12.25.
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

#import "RFUIKeyboardCenter.h"

#import "RFUIKeyboardLayoutView.h"

NSString *const RFUIKeyboardCenterWillShowKeyboardNotification = @"RFUIKeyboardCenterWillShowKeyboardNotification";
NSString *const RFUIKeyboardCenterDidShowKeyboardNotification = @"RFUIKeyboardCenterDidShowKeyboardNotification"; 
NSString *const RFUIKeyboardCenterWillHideKeyboardNotification = @"RFUIKeyboardCenterWillHideKeyboardNotification"; 
NSString *const RFUIKeyboardCenterDidHideKeyboardNotification = @"RFUIKeyboardCenterDidHideKeyboardNotification";

static RFUIKeyboardCenter * RFUIKeyboardCenter_SharedCenter = nil;
static NSObject * RFUIKeyboardCenter_Synchronizer = nil;

@implementation RFUIKeyboardCenter

#pragma mark - Initializing a Class

+ (void)initialize
{
    if (self == [RFUIKeyboardCenter class])
    {
        RFUIKeyboardCenter_SharedCenter = nil;
        RFUIKeyboardCenter_Synchronizer = [[NSObject alloc] init];
    }
}

#pragma mark - Initializing and Creating a RFUIKeyboardCenter

- (id)init
{
    if ((self = [super init]))
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShowNotification:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHideNotification:) name:UIKeyboardDidHideNotification object:nil];
        
        mAnimationCurve = UIViewAnimationCurveEaseInOut;
        mAnimationDuration = 0.0;
        mDisplayState = RFUIKeyboardDisplayStateHidden;
        mFrameBegin = CGRectZero;
        mFrameEnd = CGRectZero;
    }
    
    return self;
}

#pragma mark - Getting the RFUIKeyboardCenter Instance

+ (RFUIKeyboardCenter *)sharedCenter
{
    if (!RFUIKeyboardCenter_SharedCenter)
    {
        @synchronized(RFUIKeyboardCenter_Synchronizer)
        {
            if (!RFUIKeyboardCenter_SharedCenter)
            {
                RFUIKeyboardCenter_SharedCenter = [[RFUIKeyboardCenter alloc] init];
            }
        }
    }
    
    return RFUIKeyboardCenter_SharedCenter;
}

#pragma mark - Deallocating a RFUIKeyboardCenter

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super dealloc];
}

#pragma mark - Getting the information of keyboard

@synthesize animationCurve = mAnimationCurve;
@synthesize animationDuration = mAnimationDuration;
@synthesize displayState = mDisplayState;
@synthesize frameBegin = mFrameBegin;
@synthesize frameEnd = mFrameEnd;

#pragma mark - Sending RFUIKeyboardCenter Events

- (void)sendKeyboardCenterWillShowKeyboardMessageToView:(UIView *)view
{
    if ([view isKindOfClass:[RFUIKeyboardLayoutView class]])
    {
        RFUIKeyboardLayoutView *keyboardLayoutView = (RFUIKeyboardLayoutView *)view;
        
        [keyboardLayoutView keyboardCenterWillShowKeyboard];
    }
    
    else
    {
        NSArray *subviews = [view.subviews copy];
        
        for (NSUInteger index = 0; index < subviews.count; index++)
        {
            UIView *subview = [subviews objectAtIndex:index];
            
            [self sendKeyboardCenterWillShowKeyboardMessageToView:subview];
        }

        [subviews release];
        subviews = nil;
    }
}

- (void)sendKeyboardCenterWillShowKeyboardMessageToAllWindows
{
    NSArray *windows = [[UIApplication sharedApplication].windows copy];
    
    for (NSUInteger index = 0; index < windows.count; index++)
    {
        UIWindow *window = [windows objectAtIndex:index];
        
        [self sendKeyboardCenterWillShowKeyboardMessageToView:window];
    }
    
    [windows release];
    windows = nil;
}

- (void)sendKeyboardCenterDidShowKeyboardMessageToView:(UIView *)view
{
    if ([view isKindOfClass:[RFUIKeyboardLayoutView class]])
    {
        RFUIKeyboardLayoutView *keyboardLayoutView = (RFUIKeyboardLayoutView *)view;
        
        [keyboardLayoutView keyboardCenterDidShowKeyboard];
    }
    
    else
    {
        NSArray *subviews = [view.subviews copy];
        
        for (NSUInteger index = 0; index < subviews.count; index++)
        {
            UIView *subview = [subviews objectAtIndex:index];
            
            [self sendKeyboardCenterDidShowKeyboardMessageToView:subview];
        }
        
        [subviews release];
        subviews = nil;
    }
}

- (void)sendKeyboardCenterDidShowKeyboardMessageToAllWindows
{
    NSArray *windows = [[UIApplication sharedApplication].windows copy];
    
    for (NSUInteger index = 0; index < windows.count; index++)
    {
        UIWindow *window = [windows objectAtIndex:index];
        
        [self sendKeyboardCenterDidShowKeyboardMessageToView:window];
    }
    
    [windows release];
    windows = nil;
}

- (void)sendKeyboardCenterWillHideKeyboardMessageToView:(UIView *)view
{
    if ([view isKindOfClass:[RFUIKeyboardLayoutView class]])
    {
        RFUIKeyboardLayoutView *keyboardLayoutView = (RFUIKeyboardLayoutView *)view;
        
        [keyboardLayoutView keyboardCenterWillHideKeyboard];
    }
    
    else
    {
        NSArray *subviews = [view.subviews copy];
        
        for (NSUInteger index = 0; index < subviews.count; index++)
        {
            UIView *subview = [subviews objectAtIndex:index];
            
            [self sendKeyboardCenterWillHideKeyboardMessageToView:subview];
        }
        
        [subviews release];
        subviews = nil;
    }
}

- (void)sendKeyboardCenterWillHideKeyboardMessageToAllWindows
{
    NSArray *windows = [[UIApplication sharedApplication].windows copy];
    
    for (NSUInteger index = 0; index < windows.count; index++)
    {
        UIWindow *window = [windows objectAtIndex:index];
        
        [self sendKeyboardCenterWillHideKeyboardMessageToView:window];
    }
    
    [windows release];
    windows = nil;
}

- (void)sendKeyboardCenterDidHideKeyboardMessageToView:(UIView *)view
{
    if ([view isKindOfClass:[RFUIKeyboardLayoutView class]])
    {
        RFUIKeyboardLayoutView *keyboardLayoutView = (RFUIKeyboardLayoutView *)view;
        
        [keyboardLayoutView keyboardCenterDidHideKeyboard];
    }
    
    else
    {
        NSArray *subviews = [view.subviews copy];
        
        for (NSUInteger index = 0; index < subviews.count; index++)
        {
            UIView *subview = [subviews objectAtIndex:index];
            
            [self sendKeyboardCenterDidHideKeyboardMessageToView:subview];
        }
        
        [subviews release];
        subviews = nil;
    }
}

- (void)sendKeyboardCenterDidHideKeyboardMessageToAllWindows
{
    NSArray *windows = [[UIApplication sharedApplication].windows copy];
    
    for (NSUInteger index = 0; index < windows.count; index++)
    {
        UIWindow *window = [windows objectAtIndex:index];
        
        [self sendKeyboardCenterDidHideKeyboardMessageToView:window];
    }
    
    [windows release];
    windows = nil;
}

#pragma mark - Notifications

- (void)keyboardWillShowNotification:(NSNotification *)notification
{
    if ([notification.name isEqual:UIKeyboardWillShowNotification])
    {
        NSDictionary *userInfo = [notification userInfo];
        
        NSNumber *animationCurveNumber = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
        mAnimationCurve = [animationCurveNumber unsignedIntegerValue];
        
        NSNumber *animationDurationNumber = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        mAnimationDuration = [animationDurationNumber doubleValue];
    
        mDisplayState = RFUIKeyboardDisplayStateShowing;
        
        NSValue *frameBeginValue = [userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey];
        mFrameBegin = [frameBeginValue CGRectValue];

        NSValue *frameEndValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        mFrameEnd = [frameEndValue CGRectValue];
    
        [self sendKeyboardCenterWillShowKeyboardMessageToAllWindows];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:RFUIKeyboardCenterWillShowKeyboardNotification object:self userInfo:nil];
    }
}

- (void)keyboardDidShowNotification:(NSNotification *)notification
{
    if ([notification.name isEqual:UIKeyboardDidShowNotification])
    {
        NSDictionary *userInfo = [notification userInfo];
        
        NSNumber *animationCurveNumber = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
        mAnimationCurve = [animationCurveNumber unsignedIntegerValue];
        
        NSNumber *animationDurationNumber = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        mAnimationDuration = [animationDurationNumber doubleValue];
        
        mDisplayState = RFUIKeyboardDisplayStateShown;

        NSValue *frameBeginValue = [userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey];
        mFrameBegin = [frameBeginValue CGRectValue];
        
        NSValue *frameEndValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        mFrameEnd = [frameEndValue CGRectValue];
        
        [self sendKeyboardCenterDidShowKeyboardMessageToAllWindows];

        [[NSNotificationCenter defaultCenter] postNotificationName:RFUIKeyboardCenterDidShowKeyboardNotification object:self userInfo:nil];
    }
}

- (void)keyboardWillHideNotification:(NSNotification *)notification
{
    if ([notification.name isEqual:UIKeyboardWillHideNotification])
    {
        NSDictionary *userInfo = [notification userInfo];
        
        NSNumber *animationCurveNumber = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
        mAnimationCurve = [animationCurveNumber unsignedIntegerValue];
        
        NSNumber *animationDurationNumber = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        mAnimationDuration = [animationDurationNumber doubleValue];
        
        mDisplayState = RFUIKeyboardDisplayStateHiding;

        NSValue *frameBeginValue = [userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey];
        mFrameBegin = [frameBeginValue CGRectValue];
        
        NSValue *frameEndValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        mFrameEnd = [frameEndValue CGRectValue];
        
        [self sendKeyboardCenterWillHideKeyboardMessageToAllWindows];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:RFUIKeyboardCenterWillHideKeyboardNotification object:self userInfo:nil];
    }
}

- (void)keyboardDidHideNotification:(NSNotification *)notification
{
    if ([notification.name isEqual:UIKeyboardDidHideNotification])
    {
        NSDictionary *userInfo = [notification userInfo];
        
        NSNumber *animationCurveNumber = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
        mAnimationCurve = [animationCurveNumber unsignedIntegerValue];
        
        NSNumber *animationDurationNumber = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        mAnimationDuration = [animationDurationNumber doubleValue];
        
        mDisplayState = RFUIKeyboardDisplayStateHidden;

        NSValue *frameBeginValue = [userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey];
        mFrameBegin = [frameBeginValue CGRectValue];
        
        NSValue *frameEndValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        mFrameEnd = [frameEndValue CGRectValue];

        [self sendKeyboardCenterDidHideKeyboardMessageToAllWindows];

        [[NSNotificationCenter defaultCenter] postNotificationName:RFUIKeyboardCenterDidHideKeyboardNotification object:self userInfo:nil];
    }
}

@end
