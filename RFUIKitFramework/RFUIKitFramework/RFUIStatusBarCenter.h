//
//  RFUIStatusBarCenter.h
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RFUIStatusBarCenter : NSObject
{
@private
    
    BOOL                   mIsInterfaceOrientationChanging;
    BOOL                   mIsFrameChanging;
    UIInterfaceOrientation mInterfaceOrientationBegin;
    UIInterfaceOrientation mInterfaceOrientationEnd;
    CGRect                 mFrameBegin;
    CGRect                 mFrameEnd;
}

// Getting the RFUIStatusBarCenter Instance

+ (RFUIStatusBarCenter *)sharedCenter;

// Managing Status Bar Interface Orientation

@property (nonatomic) UIInterfaceOrientation interfaceOrientation;
- (void)setInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation animated:(BOOL)animated;

@property (nonatomic, readonly) NSTimeInterval interfaceOrientationAnimationDuration;

// Controlling Status Bar Appearance

@property (nonatomic) UIStatusBarStyle style; // Default is UIStatusBarStyleDefault.
- (void)setStyle:(UIStatusBarStyle)style animated:(BOOL)animated;

@property (nonatomic) BOOL hidden;
- (void)setHidden:(BOOL)hidden withAnimation:(UIStatusBarAnimation)animation;

@property (nonatomic, readonly) CGRect frame;

// Getting the Information of Status Bar Interface Orientation

@property (nonatomic, readonly) UIInterfaceOrientation interfaceOrientationBegin;
@property (nonatomic, readonly) UIInterfaceOrientation interfaceOrientationEnd;
@property (nonatomic, readonly) BOOL                   isInterfaceOrientationChanging;

// Getting the Information of Status Bar Frame

@property (nonatomic, readonly) CGRect frameBegin;
@property (nonatomic, readonly) CGRect frameEnd;
@property (nonatomic, readonly) BOOL   isFrameChanging;

@end

FOUNDATION_EXTERN NSString * const RFUIStatusBarCenterWillChangeStatusBarFrameNotification;       // userInfo contains NSValue with new frame.
FOUNDATION_EXTERN NSString * const RFUIStatusBarCenterDidChangeStatusBarFrameNotification;        // userInfo contains NSValue with old frame.

FOUNDATION_EXTERN NSString * const RFUIStatusBarCenterWillChangeStatusBarOrientationNotification; // userInfo contains NSNumber with new orientation.
FOUNDATION_EXTERN NSString * const RFUIStatusBarCenterDidChangeStatusBarOrientationNotification;  // userInfo contains NSNumber with old orientation.
