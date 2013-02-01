//
//  REUIView.h
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "REExtendedCompiler.h"

UIKIT_STATIC_INLINE UIViewAnimationOptions UIViewAnimationOptionsFromUIViewAnimationCurve(UIViewAnimationCurve viewAnimationCurve)
{
    UIViewAnimationOptions viewAnimationOptions = (viewAnimationCurve & 0x0000000F) << 16;
    return viewAnimationOptions;
}

UIKIT_STATIC_INLINE UIViewAnimationCurve UIViewAnimationCurveFromUIViewAnimationOptions(UIViewAnimationOptions viewAnimationOptions)
{
    UIViewAnimationCurve viewAnimationCurve = (UIViewAnimationCurve)((viewAnimationOptions >> 16) & 0x0000000F);
    return viewAnimationCurve;
}

UIKIT_STATIC_INLINE UIViewAnimationOptions UIViewAnimationOptionsFromUIViewAnimationTransition(UIViewAnimationTransition viewAnimationTransition)
{
    UIViewAnimationOptions viewAnimationOptions = (viewAnimationTransition & 0x0000000F) << 20;
    return viewAnimationOptions;
}

UIKIT_STATIC_INLINE UIViewAnimationTransition UIViewAnimationTransitionFromUIViewAnimationOptions(UIViewAnimationOptions viewAnimationOptions)
{
    UIViewAnimationTransition viewAnimationTransition = (UIViewAnimationTransition)((viewAnimationOptions >> 20) & 0x0000000F);
    return viewAnimationTransition;
}

@interface UIView (UIViewREUIView)

// Initializing and Creating a UIView

+ (id)view;
+ (id)viewWithFrame:(CGRect)frame;

// Configuring a View’s Visual Appearance

- (void)setAlphaIfNeeded:(CGFloat)alpha;

// Configuring the Bounds and Frame Rectangles

- (void)setBoundsIfNeeded:(CGRect)bounds;
- (void)setCenterIfNeeded:(CGPoint)center;
- (void)setFrameIfNeeded:(CGRect)frame;
- (void)setTransformIfNeeded:(CGAffineTransform)transform;

// Managing the View Hierarchy

- (void)bringToFront;
- (void)sendToBack;

// Laying out Subviews

- (void)setNeedsLayoutAndLayoutIfNeeded;

- (void)recursiveLayoutSubviews;
- (void)recursiveSetNeedsLayout;
- (void)recursiveLayoutIfNeeded;
- (void)recursiveSetNeedsLayoutAndLayoutIfNeeded;

@end
