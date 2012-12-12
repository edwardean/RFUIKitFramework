//
//  RFUIForwardView.m
//  RFUIKitFramework
//  https://github.com/oliromole/RFUIKitFramework.git
//
//  Created by Roman Oliichuk on 2012.07.30.
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

#import "RFUIForwardView.h"

@implementation RFUIForwardView

#pragma mark - Initializing and Creating a RFUIForwardView

+ (id)forwardView
{
    return RENSObjectAutorelease([[self alloc] init]);
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        mDelegate = nil;
    }
    
    return self;
}

+ (id)forwardViewWithFrame:(CGRect)frame
{
    return RENSObjectAutorelease([[self alloc] initWithFrame:frame]);
}

#pragma mark - Deallocating a RFUIForwardView

- (void)dealloc
{
    RENSObjectSuperDealloc();
}

#pragma mark - Laying out Subview

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if ([mDelegate conformsToProtocol:@protocol(RFUIForwardViewDelegate)] &&
        [mDelegate respondsToSelector:@selector(forwardViewLayoutSubviews:)])
    {
        [mDelegate forwardViewLayoutSubviews:self];
    }
}

#pragma mark - Observing View-Related Changes

- (void)didAddSubview:(UIView *)subview
{
    [super didAddSubview:subview];
    
    if ([mDelegate conformsToProtocol:@protocol(RFUIForwardViewDelegate)] &&
        [mDelegate respondsToSelector:@selector(forwardView:didAddSubview:)])
    {
        [mDelegate forwardView:self didAddSubview:subview];
    }
}

- (void)willRemoveSubview:(UIView *)subview
{
    [super willRemoveSubview:subview];
    
    if ([mDelegate conformsToProtocol:@protocol(RFUIForwardViewDelegate)] &&
        [mDelegate respondsToSelector:@selector(forwardView:willRemoveSubview:)])
    {
        [mDelegate forwardView:self willRemoveSubview:subview];
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if ([mDelegate conformsToProtocol:@protocol(RFUIForwardViewDelegate)] &&
        [mDelegate respondsToSelector:@selector(forwardView:willMoveToSuperview:)])
    {
        [mDelegate forwardView:self willMoveToSuperview:newSuperview];
    }
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    if ([mDelegate conformsToProtocol:@protocol(RFUIForwardViewDelegate)] &&
        [mDelegate respondsToSelector:@selector(forwardViewDidMoveToSuperview:)])
    {
        [mDelegate forwardViewDidMoveToSuperview:self];
    }
}

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    
    if ([mDelegate conformsToProtocol:@protocol(RFUIForwardViewDelegate)] &&
        [mDelegate respondsToSelector:@selector(forwardView:willMoveToWindow:)])
    {
        [mDelegate forwardView:self willMoveToWindow:newWindow];
    }
}

- (void)didMoveToWindow
{
    [super didMoveToWindow];
    
    if ([mDelegate conformsToProtocol:@protocol(RFUIForwardViewDelegate)] &&
        [mDelegate respondsToSelector:@selector(forwardViewDidMoveToWindow:)])
    {
        [mDelegate forwardViewDidMoveToWindow:self];
    }
}

#pragma mark - Managing the Delegate

@synthesize delegate = mDelegate;

@end
