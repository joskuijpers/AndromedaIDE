//
//  SRKTileSet.h
//  Sphere
//
//  Created by Jos Kuijpers on 04/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SRKFile.h"

@class SRKImage, SRKObstructionMap;

/**
 * A tile set. Also the representation of .rts files
 */
@interface SRKTileSet : SRKFile

/// Size of a single tile
@property (readonly,assign) NSSize tileSize;

/// An array of SRKTiles
@property (readonly,strong) NSArray *tiles;

@end

/**
 * Representation of a tile
 */
@interface SRKTile : NSObject

/// Image of the tile
@property (strong) SRKImage *image;

/// Name of the tile
@property (copy) NSString *name;

/// Whether the tile is animated
@property (assign) BOOL animated;

/// The next tile in the animation
@property (assign) int nextTile;

/// The tile-delay in the animation, given in frames
@property (assign) int delay;

/// The obstruction map for the tile. nil if no obstruction.
@property (strong) SRKObstructionMap *obstructionMap;

@end

