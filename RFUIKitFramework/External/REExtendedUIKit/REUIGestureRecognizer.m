//
//  REUIGestureRecognizer.m
//  REUIKitFramework
//  https://github.com/oliromole/REExtendedUIKit.git
//
//  Created by Roman Oliichuk on 2012.11.08.
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

#import "REUIGestureRecognizer.h"

#import "REExtendedFoundation.h"

#import "REUIBlockAction.h"

NSString * const UIGestureRecognizerBlockActionsKey = @"UIGestureRecognizerBlockActionsKey";

@implementation UIGestureRecognizer (UIGestureRecognizerREUIGestureRecognizer)

#pragma mark - Initializing and Creating a UIGestureRecognizer

+ (id)gestureRecognizerWithTarget:(id)target action:(SEL)action
{
    return [[[self alloc] initWithTarget:target action:action] autorelease];
}

- (id)initWithBlockAction:(void (^)(id sender))block
{
    NSAssert(block, @"The block argument is invalid. The argument is nil.");
    
    REUIBlockAction *blockAction = [[REUIBlockAction alloc] init];
    blockAction.block = block;
    
    NSMutableDictionary *objectDictionary = [self objectDictionary];
    
    NSMutableArray *blockActions = [objectDictionary objectForKey:UIGestureRecognizerBlockActionsKey];
    
    if (!blockActions)
    {
        blockActions = [NSMutableArray array];
        
        [objectDictionary setObject:blockActions forKey:UIGestureRecognizerBlockActionsKey];
    }
    
    [blockActions addObject:blockAction];
    
    if ((self = [self initWithTarget:blockAction action:@selector(sendAction:)]))
    {
    }
    
    [blockAction release];
    blockAction = nil;
    
    return self;
}

+ (id)gestureRecognizerWithBlockAction:(void (^)(id sender))block
{
    return [[[self alloc] initWithBlockAction:block] autorelease];
}

#pragma mark - Adding and Removing Block Actions

- (void)addBlockAction:(void (^)(id control))block
{
    NSAssert(block, @"The block argument is invalid. The argument is nil.");
    
    REUIBlockAction *blockAction = [[REUIBlockAction alloc] init];
    blockAction.block = block;
    
    NSMutableDictionary *objectDictionary = [self objectDictionary];
    
    NSMutableArray *blockActions = [objectDictionary objectForKey:UIGestureRecognizerBlockActionsKey];
    
    if (!blockActions)
    {
        blockActions = [NSMutableArray array];
        
        [objectDictionary setObject:blockActions forKey:UIGestureRecognizerBlockActionsKey];
    }
    
    [blockActions addObject:blockAction];
    
    [self addTarget:blockAction action:@selector(sendAction:)];
    
    [blockAction release];
    blockAction = nil;
}

- (void)removeBlockAction:(void (^)(id control))block
{
    NSMutableDictionary *objectDictionary = [self objectDictionary];
    
    NSMutableArray *blockActions = [objectDictionary objectForKey:UIGestureRecognizerBlockActionsKey];
    
    NSInteger indexOfBlockAction = blockActions.count - 1;
    
    while (indexOfBlockAction < blockActions.count)
    {
        REUIBlockAction *blockAction = [blockActions objectAtIndex:indexOfBlockAction];
        
        if (!block ||
            (block && (blockAction.block == block)))
        {
            [self removeTarget:blockAction action:@selector(sendAction:)];
            
            [blockActions removeObjectAtIndex:indexOfBlockAction];
        }
        
        indexOfBlockAction--;
    }
    
    if (blockActions && (blockActions.count == 0))
    {
        [objectDictionary removeObjectForKey:UIGestureRecognizerBlockActionsKey];
    }
}

- (NSMutableArray *)copyAllBlockActions
{
    NSMutableArray *allBlockActions = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *objectDictionary = self.objectDictionary;
    NSMutableArray *blockActions = [objectDictionary objectForKey:UIGestureRecognizerBlockActionsKey];
    
    for (REUIBlockAction *blockAction in blockActions)
    {
        void (^block)(id sender) = blockAction.block;
        
        if (block)
        {
            [allBlockActions addObject:block];
        }
    }
    
    return allBlockActions;
}

- (NSMutableArray *)allBlockActions
{
    NSMutableArray *allBlockActions = [[self copyAllBlockActions] autorelease];
    return allBlockActions;
}

@end
