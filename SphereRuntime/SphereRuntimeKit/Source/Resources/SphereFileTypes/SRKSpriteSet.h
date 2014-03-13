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

#define SRK_RSS_DEFAULT_FRAME_DELAY 8

@class SRKImage;

/**
 * A sprite set. Also the representation of .rss files
 */
@interface SRKSpriteSet : SRKFile

/// Size of each frame image
@property (readonly) NSSize frameSize;

/// Rectangle forming the base, used for touch, talk and obstruction
@property (readonly) NSRect base;

/// An array of directions of class SRKSpriteSetDirection
@property (readonly) NSArray *directions;

/// An array of NSImages
@property (readonly) NSArray *images;

/**
 * Create an image containing the initial setup of the map.
 * Useful for testing purposes.
 *
 * @return An SRKImage
 */
- (SRKImage *)overviewRender;

@end

/**
 * A direction within a sprite set. Contains animation frames.
 */
@interface SRKSpriteSetDirection : NSObject

/// Custom name of the direction
@property (copy) NSString *name;

/// Array of frames of class SRKSpriteSetFrame.
@property (strong) NSArray *frames;

@end

/**
 * A frame within the direction of a sprite set. Contains image-references.
 */
@interface SRKSpriteSetFrame : NSObject

/// Index of the image used in this frame
@property (assign) int index;

/// Animation delay to the next frame. Delay in Frames
@property (assign) int animationDelay;

@end