//
//  RENSNumber.h
//  REExtendedFoundation
//  https://github.com/oliromole/REExtendedFoundation.git
//
//  Created by Roman Oliichuk on 2012.07.20.
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

@interface NSNumber (NSNumberRENSNumber)

@end

FOUNDATION_EXTERN NSNumber * NSNumberCharZero;
FOUNDATION_EXTERN NSNumber * NSNumberUnsignedCharZero;
FOUNDATION_EXTERN NSNumber * NSNumberShortZero;
FOUNDATION_EXTERN NSNumber * NSNumberUnsignedShortZero;
FOUNDATION_EXTERN NSNumber * NSNumberIntZero;
FOUNDATION_EXTERN NSNumber * NSNumberUnsignedIntZero;
FOUNDATION_EXTERN NSNumber * NSNumberLongZero;
FOUNDATION_EXTERN NSNumber * NSNumberUnsignedLongZero;
FOUNDATION_EXTERN NSNumber * NSNumberLongLongZero;
FOUNDATION_EXTERN NSNumber * NSNumberUnsignedLongLongZero;
FOUNDATION_EXTERN NSNumber * NSNumberFloatZero;
FOUNDATION_EXTERN NSNumber * NSNumberDoubleZero;
FOUNDATION_EXTERN NSNumber * NSNumberIntegerZero;
FOUNDATION_EXTERN NSNumber * NSNumberUnsignedIntegerZero;

FOUNDATION_EXTERN NSNumber * NSNumberCharOne;
FOUNDATION_EXTERN NSNumber * NSNumberUnsignedCharOne;
FOUNDATION_EXTERN NSNumber * NSNumberShortOne;
FOUNDATION_EXTERN NSNumber * NSNumberUnsignedShortOne;
FOUNDATION_EXTERN NSNumber * NSNumberIntOne;
FOUNDATION_EXTERN NSNumber * NSNumberUnsignedIntOne;
FOUNDATION_EXTERN NSNumber * NSNumberLongOne;
FOUNDATION_EXTERN NSNumber * NSNumberUnsignedLongOne;
FOUNDATION_EXTERN NSNumber * NSNumberLongLongOne;
FOUNDATION_EXTERN NSNumber * NSNumberUnsignedLongLongOne;
FOUNDATION_EXTERN NSNumber * NSNumberFloatOne;
FOUNDATION_EXTERN NSNumber * NSNumberDoubleOne;
FOUNDATION_EXTERN NSNumber * NSNumberIntegerOne;
FOUNDATION_EXTERN NSNumber * NSNumberUnsignedIntegerOne;

#define NSNumberCharFromBool(value) ((value) ? NSNumberCharOne : NSNumberCharZero)
#define NSNumberUnsignedCharFromBool(value) ((value) ? NSNumberUnsignedCharOne : NSNumberUnsignedCharZero)
#define NSNumberShortFromBool(value) ((value) ? NSNumberShortOne : NSNumberShortZero)
#define NSNumberUnsignedShortFromBool(value) ((value) ? NSNumberUnsignedShortOne : NSNumberUnsignedShortZero)
#define NSNumberIntFromBool(value) ((value) ? NSNumberIntOne : NSNumberIntZero)
#define NSNumberUnsignedIntFromBool(value) ((value) ? NSNumberUnsignedIntOne : NSNumberUnsignedIntZero)
#define NSNumberLongFromBool(value) ((value) ? NSNumberLongOne : NSNumberLongZero)
#define NSNumberUnsignedLongFromBool(value) ((value) ? NSNumberUnsignedLongOne : NSNumberUnsignedLongZero)
#define NSNumberLongLongFromBool(value) ((value) ? NSNumberLongLongOne : NSNumberLongLongZero)
#define NSNumberUnsignedLongLongFromBool(value) ((value) ? NSNumberUnsignedLongLongOne : NSNumberUnsignedLongLongZero)
#define NSNumberFloatFromBool(value) ((value) ? NSNumberFloatOne : NSNumberFloatZero)
#define NSNumberUnsignedFloatFromBool(value) ((value) ? NSNumberUnsignedFloatOne : NSNumberUnsignedFloatZero)
#define NSNumberDoubleFromBool(value) ((value) ? NSNumberDoubleOne : NSNumberDoubleZero)
#define NSNumberUnsignedDoubleFromBool(value) ((value) ? NSNumberUnsignedDoubleOne : NSNumberUnsignedDoubleZero)
#define NSNumberIntegerFromBool(value) ((value) ? NSNumberIntegerOne : NSNumberIntegerZero)
#define NSNumberUnsignedIntegerFromBool(value) ((value) ? NSNumberUnsignedIntegerOne : NSNumberUnsignedIntegerZero)

#define NSBoolFromNumberChar(value) (![(value) isEqual:NSNumberCharZero])
#define NSBoolFromNumberUnsignedChar(value) (![(value) isEqual:NSNumberUnsignedCharZero])
#define NSBoolFromNumberShort(value) (![(value) isEqual:NSNumberShortZero])
#define NSBoolFromNumberUnsignedShort(value) (![(value) isEqual:NSNumberUnsignedShortZero])
#define NSBoolFromNumberInt(value) (![(value) isEqual:NSNumberIntZero])
#define NSBoolFromNumberUnsignedInt(value) (![(value) isEqual:NSNumberUnsignedIntZero])
#define NSBoolFromNumberLong(value) (![(value) isEqual:NSNumberLongZero])
#define NSBoolFromNumberUnsignedLong(value) (![(value) isEqual:NSNumberUnsignedLongZero])
#define NSBoolFromNumberLongLong(value) (![(value) isEqual:NSNumberLongLongZero])
#define NSBoolFromNumberUnsignedLongLong(value) (![(value) isEqual:NSNumberUnsignedLongLongZero])
#define NSBoolFromNumberFloat(value) (![(value) isEqual:NSNumberFloatZero])
#define NSBoolFromNumberUnsignedFloat(value) (![(value) isEqual:NSNumberUnsignedFloatZero])
#define NSBoolFromNumberDouble(value) (![(value) isEqual:NSNumberDoubleZero])
#define NSBoolFromNumberUnsignedDouble(value) (![(value) isEqual:NSNumberUnsignedDoubleZero])
#define NSBoolFromNumberInteger(value) (![(value) isEqual:NSNumberIntegerZero])
#define NSBoolFromNumberUnsignedInteger(value) (![(value) isEqual:NSNumberUnsignedIntegerZero])
