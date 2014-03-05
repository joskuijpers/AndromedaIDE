//
//  SRKObstructionMap.h
//  Sphere
//
//  Created by Jos Kuijpers on 04/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

/**
 * A set containing segments of obstruction rectangles.
 */
@interface SRKObstructionMap : NSObject

/**
 * Test collision of two segments
 *
 * @return YES when they collide, NO if they do not
 * @todo rename to doesCollide or so
 */
+ (BOOL)testSegment:(NSRect)s0 withSegment:(NSRect)s1;

/**
 * Number of segments in the map.
 * @see -[numberOfSegments]
 */
- (size_t)size;

/**
 * Number of segments in the map.
 */
- (size_t)numberOfSegments;

/**
 * Adds a segment
 *
 * @param segment The segment
 */
- (void)addSegment:(NSRect)segment;

- (BOOL)testRect:(NSRect)rect;

/**
 * Tries to simplify the obstruction map for performance
 */
- (void)simplify;

@end
