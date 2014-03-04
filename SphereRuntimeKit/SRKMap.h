//
//  SRKFileRMP.h
//  Sphere
//
//  Created by Jos Kuijpers on 24/02/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SRKFile.h"

typedef enum {
	SRKMapEdgeNorth = 0,
	SRKMapEdgeEast = 1,
	SRKMapEdgeSouth = 2,
	SRKMapEdgeWest = 3
} SRKMapEdge;

@class SRKObstructionMap, SRKTileSet;

@interface SRKMap : SRKFile

@property (readonly,assign) NSPoint startLocation;
@property (readonly,assign) uint8_t startLayer; // object instead?
@property (readonly,assign) int startDirection;
@property (readonly,assign,getter=isRepeating) BOOL repeating;

@property (readonly,copy) NSString *musicFilename;

@property (readonly,strong) NSString *entryScript;
@property (readonly,strong) NSString *exitScript;
@property (readonly,strong) NSArray *edgeScripts;

@property (readonly,strong) NSArray *layers;
@property (readonly,strong) NSArray *entities;
@property (readonly,strong) NSArray *zones;

@property (readonly,strong) SRKTileSet *tileSet;

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
