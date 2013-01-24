//
//  RECGGeometry.h
//  REExtendedCoreGraphics
//  https://github.com/oliromole/REExtendedCoreGraphics.git
//
//  Created by Roman Oliichuk on 2012.12.20.
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

CG_INLINE bool CGPointIsZero(CGPoint point)
{
    bool result = ((point.x == 0.0f) && (point.y == 0.0f));
    return result;
}

CG_INLINE CGPoint CGPointIntersection(CGPoint point1, CGPoint point2)
{
    CGPoint intersectedPoint;
    intersectedPoint.x = (point1.x < point2.x ? point1.x : point2.x);
    intersectedPoint.y = (point1.y < point2.y ? point1.y : point2.y);
    return intersectedPoint;
}

CG_INLINE CGPoint CGPointUnion(CGPoint point1, CGPoint point2)
{
    CGPoint unitedPoint;
    unitedPoint.x = (point1.x > point2.x ? point1.x : point2.x);
    unitedPoint.y = (point1.y > point2.y ? point1.y : point2.y);
    return unitedPoint;
}

CG_INLINE bool CGSizeIsZero(CGSize size)
{
    bool result = ((size.width == 0.0f) && (size.height == 0.0f));
    return result;
}

CG_INLINE CGSize CGSizeIntersection(CGSize size1, CGSize size2)
{
    CGSize intersectedSize;
    intersectedSize.width = (size1.width < size2.width ? size1.width : size2.width);
    intersectedSize.height = (size1.height < size2.height ? size1.height : size2.height);
    return intersectedSize;
}

CG_INLINE CGSize CGSizeUnion(CGSize size1, CGSize size2)
{
    CGSize unitedSize;
    unitedSize.width = (size1.width > size2.width ? size1.width : size2.width);
    unitedSize.height = (size1.height > size2.height ? size1.height : size2.height);
    return unitedSize;
}
