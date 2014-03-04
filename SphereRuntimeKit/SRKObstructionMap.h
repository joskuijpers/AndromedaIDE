//
//  SRKObstructionMap.h
//  Sphere
//
//  Created by Jos Kuijpers on 04/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

@interface SRKObstructionMap : NSObject

+ (BOOL)testSegment:(NSRect)s0 withSegment:(NSRect)s1;

- (size_t)size;
- (size_t)numberOfSegments;

- (void)addSegment:(NSRect)segment;
- (BOOL)testRect:(NSRect)rect;

- (void)simplify;

@end
