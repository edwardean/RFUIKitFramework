//
//  RFUIPageScrollView.m
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

#import "RFUIPageScrollView.h"

#import "RFUIPageScrollViewCell.h"

@implementation RFUIPageScrollView

#pragma mark - Initializing a RFUIPageScrollView

- (id)init
{
    CGRect mainScreenBounds = [UIScreen mainScreen].bounds;
    
    return [self initWithFrame:CGRectMake(0.0f, 0.0f, mainScreenBounds.size.width, mainScreenBounds.size.height)];
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        mDataSource = nil;
        
        mNumberOfRows = 0;
        mNumberOfColumns = 0;
        
        mOldPageIndePath = nil;
        mPageIndexPath = nil;
        mPageSize = self.bounds.size;
        mRows = [[NSMutableArray alloc] init];
        mVisibleCells = [[NSMutableArray alloc] init];
        
        mNeedsReloadData = YES;
        
        self.pagingEnabled = YES;
    }
    
    return self;
}

#pragma mark - Deallocating a RFUIPageScrollView

- (void)dealloc
{
    RENSObjectRelease(mOldPageIndePath);
    mOldPageIndePath = nil;
    
    RENSObjectRelease(mPageIndexPath);
    mPageIndexPath = nil;
    
    RENSObjectRelease(mRows);
    mRows = nil;
    
    RENSObjectRelease(mVisibleCells);
    mVisibleCells = nil;
    
    RENSObjectSuperDealloc();
}

#pragma mark - Lays out Subviews

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    @autoreleasepool
    {
        if (mNeedsReloadData)
        {
            [self reloadData];
        }
        
        CGSize oldPageSize = mPageSize;
        CGSize newPageSize = self.bounds.size;
        
        if (!CGSizeEqualToSize(oldPageSize, newPageSize))
        {
            mPageSize = newPageSize;
            
            CGPoint contentOffset = CGPointZero;
            
            if (mOldPageIndePath)
            {
                contentOffset.x = newPageSize.width * mOldPageIndePath.column;
                contentOffset.y = newPageSize.height * mOldPageIndePath.row;
            }
            
            if (!CGPointEqualToPoint(self.contentOffset, contentOffset))
            {
                [self setContentOffset:contentOffset animated:NO];
            }
        }
        
        CGRect viewFrame = self.frame;
        
        CGSize contentSize;
        contentSize.width = mNumberOfColumns * viewFrame.size.width;
        contentSize.height = mNumberOfRows * viewFrame.size.height;
        
        if (!CGSizeEqualToSize(self.contentSize, contentSize))
        {
            self.contentSize = contentSize;
        }
        
        viewFrame = self.frame;
        CGPoint contentOffset = self.contentOffset;
        
        NSMutableSet *indexPaths = [[NSMutableSet alloc] initWithCapacity:4];
        
        NSInteger indexOfRow0 = (NSInteger)truncf(contentOffset.y / viewFrame.size.height);
        NSInteger indexOfRow1 = (NSInteger)truncf((contentOffset.y + viewFrame.size.height - 1.0) / viewFrame.size.height);
        
        NSInteger indexOfColumn0 = (NSInteger)truncf(contentOffset.x / viewFrame.size.width);
        NSInteger indexOfColumn1 = (NSInteger)truncf((contentOffset.x + viewFrame.size.width - 1.0) / viewFrame.size.width);
        
        if ((indexOfRow0 >= 0) && (indexOfRow0 < mNumberOfRows) &&
            (indexOfColumn0 >= 0) && (indexOfColumn0 < mNumberOfColumns))
        {
            [indexPaths addObject:[NSIndexPath indexPathForRow:indexOfRow0 column:indexOfColumn0]];
        }
        
        if ((indexOfRow0 >= 0) && (indexOfRow0 < mNumberOfRows) &&
            (indexOfColumn1 >= 0) && (indexOfColumn1 < mNumberOfColumns))
        {
            [indexPaths addObject:[NSIndexPath indexPathForRow:indexOfRow0 column:indexOfColumn1]];
        }
        
        if ((indexOfRow1 >= 0) && (indexOfRow1 < mNumberOfRows) &&
            (indexOfColumn0 >= 0) && (indexOfColumn0 < mNumberOfColumns))
        {
            [indexPaths addObject:[NSIndexPath indexPathForRow:indexOfRow1 column:indexOfColumn0]];
        }
        
        if ((indexOfRow1 >= 0) && (indexOfRow1 < mNumberOfRows) &&
            (indexOfColumn1 >= 0) && (indexOfColumn1 < mNumberOfColumns))
        {
            [indexPaths addObject:[NSIndexPath indexPathForRow:indexOfRow1 column:indexOfColumn1]];
        }
        
        // Removing and updating the cell.
        NSInteger indexOfVisibleCell = 0;
        
        while (indexOfVisibleCell < [mVisibleCells count])
        {
            RFUIPageScrollViewCell *pageScrollViewCell = [mVisibleCells objectAtIndex:indexOfVisibleCell];
            NSIndexPath *indexPath = [self indexPathForCell:pageScrollViewCell];
            
            if (indexPath)
            {
                if ([indexPaths containsObject:indexPath])
                {
                    CGRect pageScrollViewCellFrame;
                    pageScrollViewCellFrame.origin.x = indexPath.column * viewFrame.size.width;
                    pageScrollViewCellFrame.origin.y = indexPath.row * viewFrame.size.height;
                    pageScrollViewCellFrame.size.width = viewFrame.size.width;
                    pageScrollViewCellFrame.size.height = viewFrame.size.height;
                    
                    if (!CGRectEqualToRect(pageScrollViewCell.frame, pageScrollViewCellFrame))
                    {
                        pageScrollViewCell.frame = pageScrollViewCellFrame;
                    }
                    
                    [indexPaths removeObject:indexPath];
                    
                    indexOfVisibleCell++;
                }
                
                else
                {
                    [pageScrollViewCell removeFromSuperview];
                    [mVisibleCells removeObjectAtIndex:indexOfVisibleCell];
                    [[mRows objectAtIndex:indexPath.row] replaceObjectAtIndex:indexPath.column withObject:[NSNull null]];
                }
            }
            
            else
            {
                [pageScrollViewCell removeFromSuperview];
                [mVisibleCells removeObjectAtIndex:indexOfVisibleCell];
            }
        }
        
        // Loading New Cell.
        for (NSIndexPath *indexPath in indexPaths)
        {
            RFUIPageScrollViewCell *pageScrollViewCell = [self cellForRowAtIndexPathInDataSource:indexPath];
            
            CGRect pageScrollViewCellFrame;
            pageScrollViewCellFrame.origin.x = indexPath.column * viewFrame.size.width;
            pageScrollViewCellFrame.origin.y = indexPath.row * viewFrame.size.height;
            pageScrollViewCellFrame.size.width = viewFrame.size.width;
            pageScrollViewCellFrame.size.height = viewFrame.size.height;
            
            if (!CGRectEqualToRect(pageScrollViewCell.frame, pageScrollViewCellFrame))
            {
                pageScrollViewCell.frame = pageScrollViewCellFrame;
            }
            
            [[mRows objectAtIndex:indexPath.row] replaceObjectAtIndex:indexPath.column withObject:pageScrollViewCell];
            [mVisibleCells addObject:pageScrollViewCell];
            
            [self addSubview:pageScrollViewCell];
        }
        
        RENSObjectRelease(indexPaths);
        indexPaths = nil;
    }
}

#pragma mark - Managing the Display of Content

- (void)calculatePageIndex
{
    CGRect visibleContentFrame;
    visibleContentFrame.origin = self.contentOffset;
    visibleContentFrame.size = self.frame.size;
    
    BOOL needNewPageIndex = NO;
    
    if (mPageIndexPath)
    {
        CGRect pageFrame;
        pageFrame.origin.x = mPageIndexPath.column * visibleContentFrame.size.width - visibleContentFrame.size.width / 2.0f;
        pageFrame.origin.y = mPageIndexPath.row * visibleContentFrame.size.height - visibleContentFrame.size.height / 2.0f;
        pageFrame.size.width = visibleContentFrame.size.width / 2.0f;
        pageFrame.size.height = visibleContentFrame.size.height / 2.0f;
        
        if (!CGRectIntersectsRect(visibleContentFrame, pageFrame))
        {
            needNewPageIndex = YES;
        }
    }
    
    else
    {
        needNewPageIndex = YES;
    }
    
    if (needNewPageIndex)
    {
        NSIndexPath *pageIndexPath = nil;
        
        if ((mNumberOfRows > 0) && (mNumberOfColumns > 0))
        {
            CGPoint point;
            point.x = CGRectGetMidX(visibleContentFrame);
            point.y = CGRectGetMidY(visibleContentFrame);
            
            NSInteger column = (NSInteger)truncf(point.x / visibleContentFrame.size.width);
            NSInteger row = (NSInteger)truncf(point.y / visibleContentFrame.size.height);
            
            if (row < 0)
            {
                row = 0;
            }
            
            if (row >= mNumberOfRows)
            {
                row = mNumberOfRows - 1;
            }
            
            if (column < 0)
            {
                column = 0;
            }
            
            if (column >= mNumberOfColumns)
            {
                column = 0;
            }
            
            pageIndexPath = RENSObjectRetain([NSIndexPath indexPathForRow:row column:column]);
        }
        
        if ((mPageIndexPath != pageIndexPath) &&  ![mPageIndexPath isEqual:pageIndexPath])
        {
            NSIndexPath *oldPageIndexPath = RENSObjectRetain(mPageIndexPath);
            
            RENSObjectRelease(mPageIndexPath);
            mPageIndexPath = RENSObjectRetain(pageIndexPath);
            
            id delegate = self.delegate;
            
            if ([delegate conformsToProtocol:@protocol(RFUIPageScrollViewDelegate)] &&
                [delegate respondsToSelector:@selector(pageScrollView:didChangeToPageIndexPath:fromPageIndexPath:)])
            {
                [delegate pageScrollView:self didChangeToPageIndexPath:mPageIndexPath fromPageIndexPath:oldPageIndexPath];
            }
            
            RENSObjectRelease(oldPageIndexPath);
            oldPageIndexPath = nil;
        }
        
        RENSObjectRelease(pageIndexPath);
        pageIndexPath = nil;
    }
}

- (void)setContentOffset:(CGPoint)contentOffset
{
    [super setContentOffset:contentOffset];
    
    CGSize pageSize = self.bounds.size;
    
    [self calculatePageIndex];
    
    if (CGSizeEqualToSize(mPageSize, pageSize))
    {
        RENSObjectRelease(mOldPageIndePath);
        mOldPageIndePath = RENSObjectRetain(mPageIndexPath);
    }
}

- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated
{
    [super setContentOffset:contentOffset animated:animated];
    
    CGSize pageSize = self.bounds.size;
    
    [self calculatePageIndex];
    
    if (CGSizeEqualToSize(mPageSize, pageSize))
    {
        if (mOldPageIndePath != mPageIndexPath)
        {
            RENSObjectRelease(mOldPageIndePath);
            mOldPageIndePath = RENSObjectRetain(mPageIndexPath);
        }
    }
}

#pragma mark - Managing the Delegate

- (id<RFUIPageScrollViewDelegate, UIScrollViewDelegate>)delegate
{
    return (id<RFUIPageScrollViewDelegate, UIScrollViewDelegate>)super.delegate;
}

- (void)setDelegate:(id<RFUIPageScrollViewDelegate,UIScrollViewDelegate>)delegate
{
    super.delegate = delegate;
}

#pragma mark - Specifying the Data Source

@synthesize dataSource = mDataSource;

- (NSInteger)numberOfColumnsInDataSource
{
    NSInteger numberOfCollumns = 0;
    
    if (mDataSource)
    {
        numberOfCollumns = [mDataSource numberOfColumnInPageScrollView:self];
    }
    
    return numberOfCollumns;
}

- (NSInteger)numberOfRowsInDataSource
{
    NSInteger numberOfRows = 0;
    
    if (mDataSource)
    {
        numberOfRows = [mDataSource numberOfRowsInPageScrollView:self];
    }
    
    return numberOfRows;
}

- (RFUIPageScrollViewCell *)cellForRowAtIndexPathInDataSource:(NSIndexPath *)indexPath
{
    RFUIPageScrollViewCell *pageScrollViewCell = nil;
    
    if (mDataSource)
    {
        pageScrollViewCell = RENSObjectRetain([mDataSource pageScrollView:self cellForRowAtIndexPath:indexPath]);
    }
    
    if (!pageScrollViewCell)
    {
        pageScrollViewCell = [[RFUIPageScrollViewCell alloc] init];
    }
    
    return RENSObjectAutorelease(pageScrollViewCell);
}

#pragma mark - Accessing Info

- (NSInteger)numberOfColumns
{
    return mNumberOfColumns;
}

- (NSInteger)numberOfRows
{
    return mNumberOfRows;
}

- (CGRect)rectForCellAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect rect = CGRectZero;
    
    if (indexPath &&
        (indexPath.row >= 0) && (indexPath.row < mNumberOfRows) &&
        (indexPath.column >= 0) && (indexPath.column < mNumberOfColumns))
    {
        CGRect viewFrame = self.frame;
        
        CGRect pageScrollViewCellFrame;
        pageScrollViewCellFrame.origin.x = indexPath.column * viewFrame.size.width;
        pageScrollViewCellFrame.origin.y = indexPath.row * viewFrame.size.height;
        pageScrollViewCellFrame.size.width = viewFrame.size.width;
        pageScrollViewCellFrame.size.height = viewFrame.size.height;
    }
    
    return rect;
}

- (NSIndexPath *)indexPathForRowAtPoint:(CGPoint)point
{
    CGRect viewFrame = self.frame;
    
    NSInteger row = (NSInteger)truncf(point.y / viewFrame.size.height);
    NSInteger column = (NSInteger)truncf(point.x / viewFrame.size.width);
    
    NSIndexPath *indexPath = nil;
    
    if ((row >= 0) && (row < mNumberOfRows) &&
        (column >= 0) && (column < mNumberOfColumns))
    {
        indexPath = RENSObjectRetain([NSIndexPath indexPathForRow:row column:column]);
    }
    
    return RENSObjectAutorelease(indexPath);
}

- (NSIndexPath *)indexPathForCell:(RFUIPageScrollViewCell *)cell
{
    NSIndexPath *indexPath = nil;
    
    if (cell)
    {
        for (NSInteger indexOfRow = 0; indexOfRow < mNumberOfRows; indexOfRow++)
        {
            NSMutableArray *columns = [mRows objectAtIndex:indexOfRow];
            
            NSInteger indexOfColumn = [columns indexOfObjectIdenticalTo:cell];
            
            if (indexOfColumn != NSNotFound)
            {
                indexPath = RENSObjectRetain([NSIndexPath indexPathForRow:indexOfRow column:indexOfColumn]);
                break;
            }
        }
    }
    
    return RENSObjectAutorelease(indexPath);
}

- (RFUIPageScrollViewCell *)cellAtIndexPath:(NSIndexPath *)indexPath
{
    RFUIPageScrollViewCell *pageScrollViewCell = nil;
    
    if ((indexPath.row >= 0) && (indexPath.row < mNumberOfRows) &&
        (indexPath.column >= 0) && (indexPath.column < mNumberOfColumns))
    {
        NSMutableArray *columns = [mRows objectAtIndex:indexPath.row];
        pageScrollViewCell = [columns objectAtIndex:indexPath.column];
        
        if ([pageScrollViewCell isEqual:[NSNull null]])
        {
            pageScrollViewCell = nil;
        }
    }
    
    return pageScrollViewCell;
}

- (NSArray *)visibleCells
{
    NSArray *visibleCells = [mVisibleCells copy];
    return RENSObjectAutorelease(visibleCells);
}

- (NSArray *)indexPathsForVisibleCells
{
    NSMutableArray *mutableIndexPaths = [[NSMutableArray alloc] initWithCapacity:[mVisibleCells count]];
    
    for (RFUIPageScrollViewCell *pageScrollViewCell in mVisibleCells)
    {
        NSIndexPath *indexPath = [self indexPathForCell:pageScrollViewCell];
        
        if (indexPath)
        {
            [mutableIndexPaths addObject:indexPath];
        }
    }
    
    NSArray *indexPaths = [mutableIndexPaths copy];
    
    RENSObjectRelease(mutableIndexPaths);
    mutableIndexPaths = nil;
    
    return RENSObjectAutorelease(indexPaths);
}

// Reloading Data

- (void)reloadData
{
    @autoreleasepool
    {
        mNeedsReloadData = NO;
        
        // Removing All Cells.
        
        [mRows removeAllObjects];
        
        for (RFUIPageScrollViewCell *pageScrollViewCell in mVisibleCells)
        {
            [pageScrollViewCell removeFromSuperview];
        }
        
        [mVisibleCells removeAllObjects];
        
        // Geting Info.
        
        mNumberOfRows = [self numberOfRowsInDataSource];
        mNumberOfColumns = [self numberOfColumnsInDataSource];
        
        // Adding Empty Cells.
        for (NSInteger indexOfRow = 0; indexOfRow < mNumberOfRows; indexOfRow++)
        {
            NSMutableArray *columns = [[NSMutableArray alloc] initWithCapacity:mNumberOfColumns];
            
            for (NSInteger indexOfColumn = 0; indexOfColumn < mNumberOfColumns; indexOfColumn++)
            {
                [columns addObject:[NSNull null]];
            }
            
            [mRows addObject:columns];
            
            RENSObjectRelease(columns);
            columns = nil;
        }
        
        CGRect viewFrame = self.frame;
        
        CGSize contentSize;
        contentSize.width = mNumberOfColumns * viewFrame.size.width;
        contentSize.height = mNumberOfRows * viewFrame.size.height;
        
        if (!CGSizeEqualToSize(self.contentSize, contentSize))
        {
            self.contentSize = contentSize;
        }
        
        [self setNeedsLayout];
        
        CGPoint contentOffset = CGPointZero;
        
        if (!CGPointEqualToPoint(self.contentOffset, contentOffset))
        {
            [self setContentOffset:contentOffset animated:NO];
        }
        
        [self calculatePageIndex];
    }
}

// Row insertion/deletion/reloading.

- (void)insertRow:(NSInteger)row
{
    NSMutableArray *columns = [[NSMutableArray alloc] initWithCapacity:mNumberOfColumns];
    
    for (NSInteger indexOfColumn = 0; indexOfColumn < mNumberOfColumns; indexOfColumn++)
    {
        [columns addObject:[NSNull null]];
    }
    
    [mRows insertObject:columns atIndex:row];
    mNumberOfRows++;
    
    RENSObjectRelease(columns);
    columns = nil;
    
    [self layoutIfNeeded];
}

- (void)insertColumn:(NSInteger)indexOfColumn
{
    for (NSInteger indexOfRow = 0; indexOfRow < mNumberOfRows; indexOfRow++)
    {
        NSMutableArray *columns = [mRows objectAtIndex:indexOfRow];
        [columns insertObject:[NSNull null] atIndex:indexOfColumn];
    }
    
    mNumberOfColumns++;
    
    [self layoutIfNeeded];
}

- (void)deleteRow:(NSInteger)indexOfRow
{
    NSMutableArray *columns = [mRows objectAtIndex:indexOfRow];
    
    for (NSInteger indexOfColumn = 0; indexOfColumn < mNumberOfColumns; indexOfColumn++)
    {
        RFUIPageScrollViewCell *pageScrollViewCell = [columns objectAtIndex:indexOfColumn];
        
        if (![pageScrollViewCell isEqual:[NSNull null]])
        {
            [pageScrollViewCell removeFromSuperview];
            [mVisibleCells removeObjectIdenticalTo:pageScrollViewCell];
        }
    }
    
    [mRows removeObjectAtIndex:indexOfRow];
    
    mNumberOfRows--;
    
    [self layoutIfNeeded];
}

- (void)deleteColumn:(NSInteger)indexOfColumn
{
    for (NSInteger indexOfRow = 0; indexOfRow < mNumberOfRows; indexOfRow++)
    {
        NSMutableArray *columns = [mRows objectAtIndex:indexOfRow];
        
        RFUIPageScrollViewCell *pageScrollViewCell = [columns objectAtIndex:indexOfColumn];
        
        if (![pageScrollViewCell isEqual:[NSNull null]])
        {
            [pageScrollViewCell removeFromSuperview];
            [mVisibleCells removeObjectIdenticalTo:pageScrollViewCell];
        }
        
        [columns removeObjectAtIndex:indexOfColumn];
    }
    
    mNumberOfColumns--;
    
    [self layoutIfNeeded];
}

- (void)reloadCellIndexPaths:(NSArray *)indexPaths
{
    for (NSIndexPath *indexPath in indexPaths)
    {
        RFUIPageScrollViewCell *pageScrollViewCell = [self cellAtIndexPath:indexPath];
        
        if (pageScrollViewCell)
        {
            RFUIPageScrollViewCell *pageScrollViewCell2 = [self cellForRowAtIndexPathInDataSource:indexPath];
            
            CGRect pageScrollViewCell2Frame = pageScrollViewCell.frame;
            
            if (!CGRectEqualToRect(pageScrollViewCell2.frame, pageScrollViewCell2Frame))
            {
                pageScrollViewCell2.frame = pageScrollViewCell2Frame;
            }
            
            [[mRows objectAtIndex:indexPath.row] replaceObjectAtIndex:indexPath.column withObject:pageScrollViewCell2];
            [mVisibleCells removeObjectIdenticalTo:pageScrollViewCell];
            [mVisibleCells addObject:pageScrollViewCell2];
            
            [pageScrollViewCell removeFromSuperview];
            [self addSubview:pageScrollViewCell2];
        }
    }
}

- (NSIndexPath *)pageIndexPath
{
    return mPageIndexPath;
}

- (void)setPageIndexPath:(NSIndexPath *)pageIndexPath
{
    [self setPageIndexPath:pageIndexPath animated:NO];
}

- (void)setPageIndexPath:(NSIndexPath *)pageIndexPath animated:(BOOL)animated
{
    NSAssert(pageIndexPath, @"The pageIndexPath argument is nil.");
    
    CGRect viewBounds = self.bounds;
    
    CGPoint contentOffset;
    contentOffset.x = viewBounds.size.width * pageIndexPath.column;
    contentOffset.y = viewBounds.size.height * pageIndexPath.row;
    
    if (!CGPointEqualToPoint(self.contentOffset, contentOffset))
    {
        [self setContentOffset:contentOffset animated:animated];
    }
}

@end

@implementation NSIndexPath (NSIndexPathRFUIPageScrollView)

#pragma mark - Initializing a NSIndexPath

+ (id)indexPathForRow:(NSInteger)row column:(NSInteger)column
{
    return [self indexPathForRow:row inSection:column];
}

#pragma mark - Properties

- (NSInteger)column
{
    NSInteger column = self.section;
    return column;
}

@end
