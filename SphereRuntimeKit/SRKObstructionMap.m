//
//  SRKObstructionMap.m
//  Sphere
//
//  Created by Jos Kuijpers on 04/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SRKObstructionMap.h"


@implementation SRKObstructionMap {
	NSMutableSet *_segments;
}

- (id)init
{
	self = [super init];
	if(self) {
		_segments = [NSMutableSet set];
	}
	return self;
}

- (size_t)size
{
	return _segments.count;
}

- (size_t)numberOfSegments
{
	return _segments.count;
}

- (void)addSegment:(NSRect)segment
{
	[_segments addObject:[NSValue valueWithRect:segment]];
}

+ (BOOL)testSegment:(NSRect)s0 withSegment:(NSRect)s1
{
	return NO;
}

- (BOOL)testRect:(NSRect)rect
{
	return NO;
}

- (void)simplify
{
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<SRKObstructionMap>{segments: %@}",_segments];
}

@end
