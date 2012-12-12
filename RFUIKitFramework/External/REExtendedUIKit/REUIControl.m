//
//  REUIControl.m
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

#import "REUIControl.h"

#import "REExtendedFoundation.h"
#import "REUIControlBlockAction.h"

NSString * const UIControlControlBlockActionsKey = @"UIControlControlBlockActionsKey";

@implementation UIControl (UIControlREUIControl)

#pragma mark - Preparing Action Messages

- (void)addBlockAction:(void (^)(id control))block forControlEvents:(UIControlEvents)controlEvents
{
    NSAssert(block, @"The block argument is nil.");
    NSAssert((controlEvents != 0), @"The controlEvents argument does not have any event.");
    
    REUIControlBlockAction *controlBlockAction = [[REUIControlBlockAction alloc] init];
    controlBlockAction.block = block;
    controlBlockAction.controlEvents = controlEvents;
    
    NSMutableDictionary *objectDictionary = [self objectDictionary];
    
    NSMutableArray *controlBlockActions = RENSObjectRetain([objectDictionary objectForKey:UIControlControlBlockActionsKey]);
    
    if (!controlBlockActions)
    {
        controlBlockActions = [[NSMutableArray alloc] init];
        
        [objectDictionary setObject:controlBlockActions forKey:UIControlControlBlockActionsKey];
    }
    
    [controlBlockActions addObject:controlBlockAction];
    
    [self addTarget:controlBlockAction action:@selector(sendAction:) forControlEvents:controlEvents];
    
    RENSObjectRelease(controlBlockAction);
    controlBlockAction = nil;
    
    RENSObjectRelease(controlBlockActions);
    controlBlockActions = nil;
}

- (void)removeBlockAction:(void (^)(id control))block forControlEvents:(UIControlEvents)controlEvents
{
    NSMutableDictionary *objectDictionary = [self objectDictionary];
    
    NSMutableArray *controlBlockActions = [objectDictionary objectForKey:UIControlControlBlockActionsKey];
    
    NSInteger indexOfControlBlockAction = controlBlockActions.count - 1;
    
    while (indexOfControlBlockAction < controlBlockActions.count)
    {
        REUIControlBlockAction *controlBlockAction = [controlBlockActions objectAtIndex:indexOfControlBlockAction];
        
        if (!block ||
            (block && (controlBlockAction.block == block)))
        {
            if ((controlBlockAction.controlEvents & controlEvents) > 0)
            {
                [self removeTarget:controlBlockAction action:@selector(sendAction:) forControlEvents:controlEvents];
                
                controlBlockAction.controlEvents &= ~controlEvents;
            }
        }
        
        if (controlBlockAction.controlEvents == 0)
        {
            [self removeTarget:controlBlockAction action:NULL forControlEvents:UIControlEventAllEvents];
            [controlBlockActions removeObjectAtIndex:indexOfControlBlockAction];
        }
        
        indexOfControlBlockAction--;
    }
    
    if (controlBlockActions && (controlBlockActions.count == 0))
    {
        [objectDictionary removeObjectForKey:UIControlControlBlockActionsKey];
    }
}

- (NSMutableArray *)copyAllBlockActions
{
    NSMutableArray *allBlockActions = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *objectDictionary = self.objectDictionary;
    NSMutableArray *controlBlockActions = [objectDictionary objectForKey:UIControlControlBlockActionsKey];
    
    for (REUIControlBlockAction *controlBlockAction in controlBlockActions)
    {
        void (^block)(id sender) = controlBlockAction.block;
        
        if (block)
        {
            [allBlockActions addObject:block];
        }
    }
    
    return allBlockActions;
}

- (NSMutableArray *)allBlockActions
{
    NSMutableArray *allBlockActions = [self copyAllBlockActions];
    return RENSObjectAutorelease(allBlockActions);
}

@end
