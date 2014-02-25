//
//  SRKWindowStyle.h
//  Sphere
//
//  Created by Jos Kuijpers on 24/02/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

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

@interface SRKWindowStyle : SRKFile

@property (readonly,strong) NSArray *images;
@property (assign) SRKWindowStyleMode backgroundMode;

- (void)setOffset:(uint8_t)offset forEdge:(SRKWindowStyleEdge)edge;
- (uint8_t)getOffsetForEdge:(SRKWindowStyleEdge)edge;

- (void)setBackgroundColor:(NSColor *)color forCorner:(SRKWindowStyleCorner)corner;
- (NSColor *)getBackgroundColorForCorner:(SRKWindowStyleCorner)corner;

- (SRKImage *)getImage:(SRKWindowStyleImage)bitmap;
- (void)setImage:(SRKImage *)image atPosition:(SRKWindowStyleImage)bitmap;

@end
