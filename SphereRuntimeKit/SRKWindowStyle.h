/*
 * Copyright (c) 2014 Jos Kuijpers. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY APPLE INC. ``AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL APPLE INC. OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "SRKFile.h"

typedef enum {
	SRKWindowStyleImageUpperLeft = 0,
	SRKWindowStyleImageTop = 1,
	SRKWindowStyleImageUpperRight = 2,
	SRKWindowStyleImageRight = 3,
	SRKWindowStyleImageLowerRight = 4,
	SRKWindowStyleImageBottom = 5,
	SRKWindowStyleImageLowerLeft = 6,
	SRKWindowStyleImageLeft = 7,
	SRKWindowStyleImageBackground = 8
} SRKWindowStyleImage;

typedef enum {
	SRKWindowStyleModeTiled,
	SRKWindowStyleModeStretched,
	SRKWindowStyleModeGradient,
	SRKWindowStyleModeTiledGradient,
	SRKWindowStyleModeStretchedGradient
} SRKWindowStyleMode;

typedef enum {
	SRKWindowStyleCornerUpperLeft = 0,
	SRKWindowStyleCornerUpperRight = 1,
	SRKWindowStyleCornerLowerLeft = 2,
	SRKWindowStyleCornerLowerRight = 3
} SRKWindowStyleCorner;

typedef enum {
	SRKWindowStyleEdgeLeft = 0,
	SRKWindowStyleEdgeTop = 1,
	SRKWindowStyleEdgeRight = 2,
	SRKWindowStyleEdgeBottom = 3
} SRKWindowStyleEdge;

@class SRKImage;

/**
 * A window style. Also the representation of .rws files
 */
@interface SRKWindowStyle : SRKFile

/// Images in the window style. Will always contain 9 items.
@property (readonly) NSArray *images;

/// The background mode: used for drawing the background
@property (assign) SRKWindowStyleMode backgroundMode;

- (void)setOffset:(uint8_t)offset forEdge:(SRKWindowStyleEdge)edge;
- (uint8_t)getOffsetForEdge:(SRKWindowStyleEdge)edge;

- (void)setBackgroundColor:(NSColor *)color forCorner:(SRKWindowStyleCorner)corner;
- (NSColor *)getBackgroundColorForCorner:(SRKWindowStyleCorner)corner;

- (SRKImage *)getImage:(SRKWindowStyleImage)bitmap;
- (void)setImage:(SRKImage *)image atPosition:(SRKWindowStyleImage)bitmap;

@end
