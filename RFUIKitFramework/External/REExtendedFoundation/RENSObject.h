//
//  RENSObject.h
//  REExtendedFoundation
//  https://github.com/oliromole/REExtendedFoundation.git
//
//  Created by Roman Oliichuk on 2012.07.23.
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

#import <objc/runtime.h>

typedef NS_ENUM(uintptr_t, NSObjectAssociationPolicy)
{
    NSObjectAssociationPolicyAssign = OBJC_ASSOCIATION_ASSIGN,                    // 0
    NSObjectAssociationPolicyRetainNonatomic = OBJC_ASSOCIATION_RETAIN_NONATOMIC, // 1
    NSObjectAssociationPolicyCopyNonatomic = OBJC_ASSOCIATION_COPY_NONATOMIC,     // 3
    NSObjectAssociationPolicyRetain = OBJC_ASSOCIATION_RETAIN,                    // 01401
    NSObjectAssociationPolicyCopy = OBJC_ASSOCIATION_COPY,                        // 01403
    
    NSObjectAssociationPolicyWeak = NSObjectAssociationPolicyAssign,                     // 0
    NSObjectAssociationPolicyStrongNonatomic = NSObjectAssociationPolicyRetainNonatomic, // 1
    NSObjectAssociationPolicyStrong = NSObjectAssociationPolicyRetain                    // 01401
};

@protocol NSInitializingInstance <NSObject>

@required

- (void)initializeInstance;
- (void)deallocateInstance;

@end

@interface NSObject (NSObjectRENSObject)

// Synchronizing the Singleton

+ (NSObject *)singletonSynchronizer;

// Managing Associative References

- (id)associatedObjectForKey:(const void *)key;
- (void)setAssociatedObject:(id)object forKey:(const void *)key policy:(NSObjectAssociationPolicy)policy;
- (void)removeAllAssociatedObjects;

// Managing the NSObject Information

@property (nonatomic, readonly) NSMutableDictionary *objectDictionary; // Default is nil. The first time the method is accessed, the NSMutableDictionary is created. This method returns nil for Core Foundation classes.

// Identifying and Comparing the Reference of Objects

- (NSComparisonResult)compareReference:(id)object;

- (BOOL)isReferenceEqual:(id)object;
- (NSUInteger)referenceHash;

+ (NSComparisonResult)compareLeftObjectReference:(id)leftObject rightObjectReference:(id)rightObject;

+ (BOOL)isEqualLeftObject:(id)leftObject rightObject:(id)rightObject;
+ (BOOL)isEqualLeftObjectReference:(id)leftObject rightObjectReference:(id)rightObject;

// Sending Messages

- (id)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3;
- (id)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4;
- (id)performSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2 withObject:(id)object3 withObject:(id)object4 withObject:(id)object5;

@end

#define NSObjectCast(object, className) ({ __typeof__(object) __object = (object); [__object isKindOfClass:[className class]] ? ((className *)(__object)) : nil; })
#define NSMutableObjectCastOrCopy(object, className) ({ __typeof__(object) __object = (object); [__object isKindOfClass:[className class]] ? ((className *)(__object)) : [(__object) mutableCopy]; })
