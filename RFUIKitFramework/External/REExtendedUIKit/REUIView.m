//
//  REUIView.m
//  REUIKitFramework
//  https://github.com/oliromole/REExtendedUIKit.git
//
//  Created by Roman Oliichuk on 2012.06.26.
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

#import "REUIView.h"

@implementation UIView (UIViewREUIView)

#pragma mark - Initializing and Creating a UIView

+ (id)view
{
    return RENSObjectAutorelease([[self alloc] init]);
}

+ (id)viewWithFrame:(CGRect)frame
{
    return RENSObjectAutorelease([[self alloc] initWithFrame:frame]);
}

#pragma mark - Configuring a View’s Visual Appearance

- (void)setAlphaIfNeeded:(CGFloat)newAlpha
{
    CGFloat oldAlpha = self.alpha;
    
    if (oldAlpha != newAlpha)
    {
        self.alpha = newAlpha;
    }
}

#pragma mark - Configuring the Bounds and Frame Rectangles

- (void)setFrameIfNeeded:(CGRect)newFrame
{
    CGRect oldFrame = self.frame;
    
    if (!CGRectEqualToRect(oldFrame, newFrame))
    {
        self.frame = newFrame;
    }
}

- (void)setBoundsIfNeeded:(CGRect)newBounds
{
    CGRect oldBounds = self.bounds;
    
    if (!CGRectEqualToRect(oldBounds, newBounds))
    {
        self.bounds = newBounds;
    }
}

- (void)setCenterIfNeeded:(CGPoint)newCenter
{
    CGPoint oldCenter = self.center;
    
    if (!CGPointEqualToPoint(oldCenter, newCenter))
    {
        self.center = newCenter;
    }
}

- (void)setTransformIfNeeded:(CGAffineTransform)newTransform
{
    CGAffineTransform oldTransform = self.transform;
    
    if (!CGAffineTransformEqualToTransform(oldTransform, newTransform))
    {
        self.transform = newTransform;
    }
}

#pragma mark - Managing the View Hierarchy

- (void)bringToFront
{
    UIView *superview = self.superview;
    [superview bringSubviewToFront:self];
}

- (void)sendToBack
{
    UIView *superview = self.superview;
    [superview sendSubviewToBack:self];
}

#pragma mark - Laying out Subviews

- (void)recursiveLayoutSubviews
{
    [self layoutSubviews];
    
    NSArray *subviews = [self.subviews copy];
    
    for (UIView *subview in subviews)
    {
        [subview recursiveLayoutSubviews];
    }
    
    RENSObjectRelease(subviews);
    subviews = nil;
}

@end
