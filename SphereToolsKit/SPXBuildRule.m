//
//  SPXBuildRule.m
//  Sphere
//
//  Created by Jos Kuijpers on 8/28/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPXBuildRule.h"

@implementation SPXBuildRule

- (id)initWithCoder:(NSCoder *)coder
{
	self = [super init];
	if(self) {
		_fileType = [coder decodeObjectForKey:@"fileType"];
		_compilerSpecification = [coder decodeObjectForKey:@"compilerSpecification"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeObject:_fileType forKey:@"fileType"];
	[coder encodeObject:_compilerSpecification forKey:@"compilerSpecification"];
}

@end
