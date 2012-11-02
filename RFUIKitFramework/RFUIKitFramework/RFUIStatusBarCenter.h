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

#import <UIKit/UIKit.h>

typedef enum RFUIStatusBarDisplayState
{
    RFUIStatusBarDisplayStateShowing = 1,
    RFUIStatusBarDisplayStateShown = 2,
    RFUIStatusBarDisplayStateHiding = 3,
    RFUIStatusBarDisplayStateHidden = 4
} RFUIStatusBarDisplayState;

@interface RFUIStatusBarCenter : NSObject
{
@private
    
    UIApplication *mApplication;
}

// Getting the RFUIStatusBarCenter Instance

+ (RFUIStatusBarCenter *)sharedCenter;

// Managing the Status Bar

@property (nonatomic) UIStatusBarStyle statusBarStyle; // Default is UIStatusBarStyleDefault.
- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle animated:(BOOL)animated;

@property (nonatomic) BOOL statusBarHidden;
- (void)setStatusBarHidden:(BOOL)hidden withAnimation:(UIStatusBarAnimation)animation;

// Rotate to a specific orientation.  This only rotates the status bar and updates the statusBarOrientation property.
// This does not change automatically if the device changes orientation.
@property (nonatomic) UIInterfaceOrientation statusBarOrientation;
- (void)setStatusBarOrientation:(UIInterfaceOrientation)interfaceOrientation animated:(BOOL)animated;

@property (nonatomic, readonly) NSTimeInterval statusBarOrientationAnimationDuration; // Returns the animation duration for the status bar during a 90 degree orientation change.  It should be doubled for a 180 degree orientation change.
@property (nonatomic, readonly) CGRect         statusBarFrame;                        // Returns CGRectZero if the status bar is hidden.

@end

FOUNDATION_EXTERN NSString * const RFUIStatusBarCenterWillChangeStatusBarFrameNotification;       // userInfo contains NSValue with new frame
FOUNDATION_EXTERN NSString * const RFUIStatusBarCenterDidChangeStatusBarFrameNotification;        // userInfo contains NSValue with old frame

FOUNDATION_EXTERN NSString * const RFUIStatusBarCenterWillChangeStatusBarOrientationNotification; // userInfo contains NSNumber with new orientation
FOUNDATION_EXTERN NSString * const RFUIStatusBarCenterDidChangeStatusBarOrientationNotification;  // userInfo contains NSNumber with old orientation

//FOUNDATION_EXTERN NSString * const RFUIStatusBarCenterStatusBarOrientationUserInfoKey;            // userInfo dictionary key for status bar orientation
//FOUNDATION_EXTERN NSString * const RFUIStatusBarCenterStatusBarFrameUserInfoKey;                  // userInfo dictionary key for status bar frame
