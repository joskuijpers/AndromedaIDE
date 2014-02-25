//
//  SRKFileRSS.h
//  Sphere
//
//  Created by Jos Kuijpers on 24/02/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SRKFile.h"

#define SRK_RSS_DEFAULT_FRAME_DELAY 8

@interface SRKSpriteSet : SRKFile

@property (readonly,assign) NSSize frameSize;
@property (readonly,assign) NSRect base;
@property (readonly,strong) NSArray *directions; // SRKSpriteSetDirection
@property (readonly,strong) NSArray *images; // NSImage

@end

@interface SRKSpriteSetDirection : NSObject

@property (copy) NSString *name;
@property (strong) NSArray *frames;

@end

@interface SRKSpriteSetFrame : NSObject

@property (assign) int index;
@property (assign) int animationDelay;

@end