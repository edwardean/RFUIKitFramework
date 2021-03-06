//
//  REUIImage.h
//  REExtendedUIKit
//  https://github.com/oliromole/REExtendedUIKit.git
//
//  Created by Roman Oliichuk on 2011.07.09.
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

UIKIT_EXTERN NSString *NSStringFromUIImageOrientation(UIImageOrientation imageOrientation);
UIKIT_EXTERN UIImageOrientation UIImageOrientationFromNSString(NSString *string);

@interface UIImage (UIImageREUIImage)

// Initializing and Creating a UIImage

- (id)initWithContentsOfFile:(NSString *)path scale:(CGFloat)scale;
+ (UIImage *)imageWithContentsOfFile:(NSString *)path scale:(CGFloat)scale;

- (id)initWithContentsOfFile:(NSString *)path scale:(CGFloat)scale orientation:(UIImageOrientation)orientation;
+ (UIImage *)imageWithContentsOfFile:(NSString *)path scale:(CGFloat)scale orientation:(UIImageOrientation)orientation;

- (id)initWithData:(NSData *)data scale:(CGFloat)scale orientation:(UIImageOrientation)orientation;
+ (UIImage *)imageWithData:(NSData *)data scale:(CGFloat)scale orientation:(UIImageOrientation)orientation;

- (id)initWithCGImage:(CGImageRef)cgImage scale:(CGFloat)scale;
+ (UIImage *)imageWithCGImage:(CGImageRef)cgImage scale:(CGFloat)scale;

- (id)initWithImage:(UIImage *)image scale:(CGFloat)scale;
+ (UIImage *)imageWithImage:(UIImage *)image scale:(CGFloat)scale;

- (id)initWithImage:(UIImage *)image orientation:(UIImageOrientation)orientation;
+ (UIImage *)imageWithImage:(UIImage *)image orientation:(UIImageOrientation)orientation;

- (id)initWithImage:(UIImage *)image scale:(CGFloat)scale orientation:(UIImageOrientation)orientation;
+ (UIImage *)imageWithImage:(UIImage *)image scale:(CGFloat)scale orientation:(UIImageOrientation)orientation;

@end

@interface UIImage (UIImageREUIImage_6_0_Dynamic)
@end

#if __IPHONE_6_0 > __IPHONE_OS_VERSION_MAX_ALLOWED

@interface UIImage (UIImageREUIImage_6_0)

// Initializing and Creating a UIImage

- (id)initWithData:(NSData *)data scale:(CGFloat)scale;
+ (UIImage *)imageWithData:(NSData *)data scale:(CGFloat)scale;

@end

#endif

#define UIImageGetImageOrientation(image) ((image).imageOrientation)

#if __IPHONE_4_0 <= __IPHONE_OS_VERSION_MIN_REQUIRED
#   define UIImageGetScale(image) ((image) ? (image).scale : 0.0f)
#elif __IPHONE_4_0 <= __IPHONE_OS_VERSION_MAX_ALLOWED
#   define UIImageGetScale(image) ((image) ? ((image) respondsToSelector:@selector(scale)] ? (image).scale : 1.0f) : 0.0f)
#else
#   define UIImageGetScale(image) ((image) ? 1.0f : 0.0f)
#endif
