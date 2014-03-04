//
//  SRKTileSet.h
//  Sphere
//
//  Created by Jos Kuijpers on 04/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SRKFile.h"

@class SRKImage, SRKObstructionMap;

@interface SRKTileSet : SRKFile

@property (readonly,assign) NSSize tileSize;
@property (readonly,strong) NSArray *tiles;

@end


@interface SRKTile : NSObject

@property (strong) SRKImage *image;
@property (copy) NSString *name;
@property (assign) BOOL animated;
@property (assign) BOOL terraformable;
@property (assign) int nextTile;
@property (assign) int delay;
@property (strong) SRKObstructionMap *obstructionMap;

@end

