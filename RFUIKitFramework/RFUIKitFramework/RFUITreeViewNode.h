//
//  RFUITreeViewNode.h
//  RFUIKitFramework
//  https://github.com/oliromole/RFUIKitFramework.git
//
//  Created by Roman Oliichuk on 2012.08.01.
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

#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "RFUITreeViewRowAnimation.h"

@class RFUITreeViewCell;

@interface RFUITreeViewNode : NSObject
{
@private
    
    NSMutableArray           *mChildTreeViewNodes;
    RFUITreeViewRowAnimation  mDeleteTreeViewRowAnimation;
    BOOL                      mIsExpanded;
    BOOL                      mNeedsGetTreeViewCellHeight;
    RFUITreeViewNode         *mParentTreeViewNode;
    RFUITreeViewCell         *mTreeViewCell;
    CGRect                    mTreeViewCellFrame;
    CGRect                    mTreeViewCellFrameOld;
    CGFloat                   mTreeViewCellHeight;
    CGFloat                   mTreeViewCellMinimumWidth;
}

// Initializing and Creating a RFUITreeViewNode

+ (id)treeViewNode;

// Manating the RFUITreeViewNode

@property (nonatomic, retain)                NSMutableArray           *childTreeViewNodes;         // Default is nil.
@property (nonatomic)                        RFUITreeViewRowAnimation  deleteTreeViewRowAnimation; // Default is RFUITreeViewRowAnimationNone.
@property (nonatomic, setter = setExpanded:) BOOL                      isExpanded;                 // Default is NO.
@property (nonatomic, assign)                BOOL                      needsGetTreeViewCellHeight; // Default is NO.
@property (nonatomic, assign)                RFUITreeViewNode         *parentTreeViewNode;         // Default is nil.
@property (nonatomic, retain)                RFUITreeViewCell         *treeViewCell;               // Default is nil.
@property (nonatomic)                        CGRect                    treeViewCellFrame;          // Default is CGRectZero.
@property (nonatomic)                        CGRect                    treeViewCellFrameOld;       // Default is CGRectZero.
@property (nonatomic)                        CGFloat                   treeViewCellHeight;         // Default is 0.0f.
@property (nonatomic)                        CGFloat                   treeViewCellMinimumWidth;   // Default is 0.0f.

@end
