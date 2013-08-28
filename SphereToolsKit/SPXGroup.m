//
//  SPXGroup.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/13/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPXGroup.h"

@implementation SPXGroup

- (instancetype)initWithName:(NSString *)name
{
	self = [super init];
	if(self) {
		self.name = name;
		_children = [NSMutableArray array];
	}
	return self;
}

- (instancetype)init
{
	return [self initWithName:nil];
}

+ (SPXGroup *)groupWithName:(NSString *)name
{
	return [[SPXGroup alloc] initWithName:name];
}

#pragma mark - Encoding

- (id)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if(self) {
		_children = [coder decodeObjectForKey:@"children"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[super encodeWithCoder:coder];

	[coder encodeObject:_children forKey:@"children"];
}

@end
