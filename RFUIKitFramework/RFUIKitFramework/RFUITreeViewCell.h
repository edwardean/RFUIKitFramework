//
//  RFUITreeViewCell.h
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

@class RFUITreeView;

@interface RFUITreeViewCell : UIView
{
@protected
    
    UIView       *mBackgroundView;
    UIView       *mContentView;
    NSInteger     mIndentationLevel;
    CGFloat       mIndentationWidth;
    NSString     *mReuseIdentifier;
    RFUITreeView *mTreeView;
}

// Initializing and Creating a RFUITreeViewCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;
+ (id)treeViewCellWithReuseIdentifier:(NSString *)reuseIdentifier;

// Managing the RFUITreeView

@property (nonatomic, strong) RFUITreeView *treeView; // Default is nil.

// Accessing Views of the Cell Object

@property (nonatomic, strong) UIView *backgroundView; // Default is nil. The first time the property is accessed, the UIView is created.
@property (nonatomic, strong) UIView *contentView;    // Default is nil. The first time the property is accessed, the UIView is created.

// Reusing Cells

@property (nonatomic, readonly, copy) NSString *reuseIdentifier; // Default is nil.
- (void)prepareForReuse;

// Managing Content Indentation

@property (nonatomic) NSInteger indentationLevel; // Default is 0. Adjust content indent.
@property (nonatomic) CGFloat   indentationWidth; // Default is 10.0f. Width for each level.

@end
