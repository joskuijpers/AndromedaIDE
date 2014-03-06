//
//  SRKFileRSS.h
//  Sphere
//
//  Created by Jos Kuijpers on 24/02/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SRKFile.h"

#define SRK_RSS_DEFAULT_FRAME_DELAY 8

@class SRKImage;

/**
 * A sprite set. Also the representation of .rss files
 */
@interface SRKSpriteSet : SRKFile

/// Size of each frame image
@property (readonly,assign) NSSize frameSize;

/// Rectangle forming the base, used for touch, talk and obstruction
@property (readonly,assign) NSRect base;

/// An array of directions of class SRKSpriteSetDirection
@property (readonly,strong) NSArray *directions;

/// An array of NSImages
@property (readonly,strong) NSArray *images;

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