//
//  RENSThread.m
//  REExtendedFoundation
//  https://github.com/oliromole/REExtendedFoundation.git
//
//  Created by Roman Oliichuk on 2012.12.02.
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

#import "RENSThread.h"

@interface RENSOtherThread : NSThread

@end

@implementation RENSOtherThread

- (void)main
{
    @autoreleasepool
    {
        @autoreleasepool
        {
            NSThread *currentThread = [NSThread currentThread];
            
            if ([currentThread respondsToSelector:@selector(setName:)])
            {
                NSString *className = NSStringFromClass([self class]);
                NSString *threadName = [NSString stringWithFormat:@"com.oliromole.%@", className];
                currentThread.name = threadName;
            }
            
            if ([currentThread respondsToSelector:@selector(setThreadPriority:)])
            {
                double mainThreadPriority = [NSThread mainThread].threadPriority;
                currentThread.threadPriority = mainThreadPriority;
            }
            
            else
            {
                double mainThreadPriority = [NSThread mainThread].threadPriority;
                [NSThread setThreadPriority:mainThreadPriority];
            }
        }
        
        SInt32 runLoopRunResult = kCFRunLoopRunTimedOut;
        
        while (!self.isCancelled && !self.isFinished && (runLoopRunResult != kCFRunLoopRunStopped))
        {
            @autoreleasepool
            {
                runLoopRunResult = CFRunLoopRunInMode(kCFRunLoopDefaultMode, 10.0, YES);
            }
        }
        
        NSAssert(!self.isCancelled, @"The %@ class is incorrectly used.", NSStringFromClass([self class]));
        NSAssert(!self.isFinished, @"The %@ class is incorrectly used.", NSStringFromClass([self class]));
        NSAssert((runLoopRunResult != kCFRunLoopRunStopped), @"The %@ class is incorrectly used.", NSStringFromClass([self class]));
    }
}

@end

static RENSOtherThread * volatile NSThread_SecondThread = nil;

@implementation NSThread (NSThreadRENSThread)

#pragma mark - Working with the Second Thread

- (BOOL)isSecondThread
{
    BOOL isSecondThread = (self == NSThread_SecondThread);
    return isSecondThread;
}

+ (BOOL)isSecondThread
{
    NSThread *currentThread = [NSThread currentThread];
    BOOL isSecondThread = (currentThread == NSThread_SecondThread);
    return isSecondThread;
}

+ (NSThread *)secondThread
{
    if (!NSThread_SecondThread)
    {
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        @synchronized(singletonSynchronizer)
        {
            if (!NSThread_SecondThread)
            {
                NSThread_SecondThread = [[RENSOtherThread alloc] init];
                [NSThread_SecondThread start];
            }
        }
    }
    
    return NSThread_SecondThread;
}

@end

@implementation NSObject (NSObjectRENSThread)

#pragma mark - Sending Messages

- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)argument waitUntilDone:(BOOL)wait modes:(NSArray *)array
{
    NSThread *secondThread = [NSThread secondThread];
    
    [self performSelector:selector onThread:secondThread withObject:argument waitUntilDone:wait modes:array];
}

- (void)performSelectorOnSecondThread:(SEL)selector withObject:(id)argument waitUntilDone:(BOOL)wait
{
    NSThread *secondThread = [NSThread secondThread];
    
    [self performSelector:selector onThread:secondThread withObject:argument waitUntilDone:wait];
}

@end
