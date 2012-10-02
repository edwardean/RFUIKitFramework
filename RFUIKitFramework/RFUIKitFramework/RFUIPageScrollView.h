//
//  RFUIPageScrollView.h
//  RFUIKitFramework
//  https://github.com/oliromole/RFUIKitFramework.git
//
//  Created by Roman Oliichuk on 2012.06.06.
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

@protocol RFUIPageScrollViewDataSource;
@protocol RFUIPageScrollViewDelegate;

@class RFUIPageScrollViewCell;

@interface RFUIPageScrollView : UIScrollView
{
@private
    
    id<RFUIPageScrollViewDataSource> mDataSource;
    
    BOOL            mNeedsReloadData;
    NSInteger       mNumberOfRows;
    NSInteger       mNumberOfColumns;
    NSIndexPath    *mOldPageIndePath;
    NSIndexPath    *mPageIndexPath;
    CGSize          mPageSize;
    NSMutableArray *mRows;
    NSMutableArray *mVisibleCells;
}

// Managing the Delegate

@property (nonatomic, assign) id<RFUIPageScrollViewDelegate, UIScrollViewDelegate> delegate;

// Specifying the Data Source
@property (nonatomic, assign) id<RFUIPageScrollViewDataSource> dataSource;

// Accessing Info

- (NSInteger)numberOfRows;
- (NSInteger)numberOfColumns;

- (CGRect)rectForCellAtIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)indexPathForRowAtPoint:(CGPoint)point;
- (NSIndexPath *)indexPathForCell:(RFUIPageScrollViewCell *)cell;
//- (NSArray *)indexPathsForRowsInRect:(CGRect)rect;

- (RFUIPageScrollViewCell *)cellAtIndexPath:(NSIndexPath *)indexPath;  // returns nil if cell is not visible or index path is out of range
- (NSArray *)visibleCells;
- (NSArray *)indexPathsForVisibleCells;

//- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;
//- (void)scrollToNearestSelectedRowAtScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;

// Reloading Data

- (void)reloadData;

// Row insertion/deletion/reloading.
- (void)insertRow:(NSInteger)row;
- (void)insertColumn:(NSInteger)column;
- (void)deleteRow:(NSInteger)row;
- (void)deleteColumn:(NSInteger)column;
- (void)reloadCellIndexPaths:(NSArray *)indexPaths;

@property (nonatomic, copy) NSIndexPath *pageIndexPath;
- (void)setPageIndexPath:(NSIndexPath *)pageIndexPath animated:(BOOL)animated;

//- (UITableView
@end


@interface NSIndexPath (NSIndexPathRFUIPageScrollView)

+ (id)indexPathForRow:(NSInteger)row column:(NSInteger)column;

@property(nonatomic,readonly) NSInteger column;

@end

@protocol RFUIPageScrollViewDataSource <NSObject>

@required

- (NSInteger)numberOfRowsInPageScrollView:(RFUIPageScrollView *)pageScrollView;
- (NSInteger)numberOfColumnInPageScrollView:(RFUIPageScrollView *)pageScrollView;

- (RFUIPageScrollViewCell *)pageScrollView:(RFUIPageScrollView *)pageScrollView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol RFUIPageScrollViewDelegate <UIScrollViewDelegate>

@optional

- (void)pageScrollView:(RFUIPageScrollView *)pageScrollView didChangeToPageIndexPath:(NSIndexPath *)newPageIndexPath fromPageIndexPath:(NSIndexPath *)oldPageIndexPath;

@end
