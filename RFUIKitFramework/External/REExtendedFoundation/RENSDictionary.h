//
//  RENSDictionary.h
//  REExtendedFoundation
//  https://github.com/oliromole/REExtendedFoundation.git
//
//  Created by Roman Oliichuk on 2012.06.26.
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

#import "REExtendedCompiler.h"

#import "RENSObject.h"

@interface NSDictionary (NSDictionaryRENSDictionary)

// Accessing Keys and Values

- (NSDictionary *)dictionaryWithKeys:(NSArray *)keys;
- (NSDictionary *)dictionaryWithKeys:(NSArray *)keys notFoundMarker:(id)marker;

@end

@interface NSDictionary (NSDictionaryRENSDictionary_6_0_Dynamic)
@end

#if __IPHONE_6_0 > __IPHONE_OS_VERSION_MAX_ALLOWED

@interface NSDictionary (NSDictionaryRENSDictionary_6_0)

// Accessing Keys and Values

- (id)objectForKeyedSubscript:(id)key;

@end

#endif

@interface NSMutableDictionary (NSMutableDictionaryRENSMutableDictionary)

// Removing Entries From a Mutable Dictionary

- (void)removeAllObjectsExceptObjectsForKeys:(NSArray *)keys;

@end

@interface NSMutableDictionary (NSMutableDictionaryRENSMutableDictionary_6_0_Dynamic)
@end

#if __IPHONE_6_0 > __IPHONE_OS_VERSION_MAX_ALLOWED

@interface NSMutableDictionary (NSMutableDictionaryRENSMutableDictionary_6_0)

// Adding Entries to a Mutable Dictionary

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key NS_AVAILABLE(10_8, 6_0);

@end

#endif

#define NSMutableDictionaryCastOrCopy(dictionary) NSMutableObjectCastOrCopy(dictionary, NSMutableDictionary)
