//
//  SRKFileRMP.h
//  Sphere
//
//  Created by Jos Kuijpers on 24/02/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SRKFile.h"

/// An edge of the map. Used in the edge script.
typedef enum {
	SRKMapEdgeNorth = 0,
	SRKMapEdgeEast = 1,
	SRKMapEdgeSouth = 2,
	SRKMapEdgeWest = 3
} SRKMapEdge;

@class SRKObstructionMap, SRKTileSet, SRKImage;

/**
 * A map. Also the representation of .rmp files
 */
@interface SRKMap : SRKFile

/// Location of the player when entering the map
@property (readonly,assign) NSPoint startLocation;

/// The layer where the player starts in. (The player-layer affects collision and touch)
@property (readonly,assign) uint8_t startLayer;

/// Start direction of the player spriteset
@property (readonly,assign) int startDirection;

/// Whether the map repeats in all directions
@property (readonly,assign,getter=isRepeating) BOOL repeating;

/// The filename of the background music. Must be relative to /sounds
@property (readonly,copy) NSString *musicFilename;

/// The script executed on entry of the map by the player
@property (readonly,strong) NSString *entryScript;

/// The script executed on exit of the map by the player
@property (readonly,strong) NSString *exitScript;

/// A list of scripts, each an NSString
@property (readonly,strong) NSArray *edgeScripts;

/// A list of layers of class SRKMapLayer
@property (readonly,strong) NSArray *layers;

/// A list of entities of class SRKMapEntity
@property (readonly,strong) NSArray *entities;

/// A list of zones of class SRKMapZone
@property (readonly,strong) NSArray *zones;

/// Tile set of this map
@property (readonly,strong) SRKTileSet *tileSet;

/**
 * Create an image containing the initial setup of the map.
 * Useful for testing purposes.
 *
 * @return An SRKImage
 */
- (SRKImage *)initialMapImage;

@end


@interface SRKMapLayer : NSObject

@property (assign) NSSize size;
@property (copy) NSString *name;
@property (assign) BOOL hasParallax;
@property (assign) NSPoint parallax;
@property (assign) NSPoint scrolling;
@property (assign,getter=isVisible) BOOL visible;
@property (assign,getter=isReflective) BOOL reflective;
@property (readonly,strong) SRKObstructionMap *obstructionMap;

- (unsigned int)tileIndexAtPoint:(NSPoint)point;

@end


@interface SRKMapZone : NSObject

@property (assign) NSRect area;
@property (assign) int layer;
@property (assign) int reactivation_steps;
@property (strong) NSString *script;

@end

@interface SRKMapEntity : NSObject

@property (assign) NSPoint location;
@property (assign) int layer;

@end

@interface SRKMapPerson : SRKMapEntity

@property (copy) NSString *name;
@property (copy) NSString *spriteSetFilename;

@property (strong) NSString *createScript;
@property (strong) NSString *destroyScript;
@property (strong) NSString *activateTouchScript;
@property (strong) NSString *activateTalkScript;
@property (strong) NSString *generateCommandsScript;

@end

@interface SRKMapTrigger : SRKMapEntity

@property (strong) NSString *script;

@end
