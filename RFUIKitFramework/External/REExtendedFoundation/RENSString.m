//
//  RENSString.m
//  REExtendedFoundation
//  https://github.com/oliromole/REExtendedFoundation.git
//
//  Created by Roman Oliichuk on 2012.06.27.
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

#import "RENSString.h"

@implementation NSString (NSStringRENSString)

#pragma mark - Getting a String’s Range

- (NSRange)range
{
    NSRange range;
    range.location = 0;
    range.length = self.length;
    
    return range;
}

#pragma mark - Identifying and Comparing Strings

- (NSComparisonResult)caseIdenticalCompare:(NSString *)rightString
{
    NSComparisonResult comparisonResult = NSOrderedDescending;
    
    if (rightString)
    {
        NSUInteger leftStringLength = self.length;
        NSUInteger rightStringLength = rightString.length;
        
        NSUInteger stringLength = MIN(leftStringLength, rightStringLength);
        
        comparisonResult = NSOrderedSame;
        
        NSUInteger index = 0;
        
        for (; index < stringLength; index++)
        {
            unichar leftCharacter = [self characterAtIndex:index];
            unichar rightCharacter = [rightString characterAtIndex:index];
            
            if (leftCharacter < rightCharacter)
            {
                comparisonResult = NSOrderedAscending;
                break;
            }
            
            else if (leftCharacter > rightCharacter)
            {
                comparisonResult = NSOrderedDescending;
                break;
            }
        }

        if (index == stringLength)
        {
            if (leftStringLength < rightStringLength)
            {
                comparisonResult = NSOrderedAscending;
            }
            
            else if (leftStringLength > rightStringLength)
            {
                comparisonResult = NSOrderedDescending;
            }
        }
    }
    
    return comparisonResult;
}

#pragma mark - Working with Encodings

- (NSData *)dataUsingUTF8StringEncoding
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}

@end

@implementation NSMutableString (NSMutableStringRENSMutableString)

#pragma mark - Modifying a String

- (void)deleteAllCharacters
{
    NSRange range;
    range.location = 0;
    range.length = self.length;
    
    [self deleteCharactersInRange:range];
}

@end
