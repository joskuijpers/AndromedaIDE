//
//  SPXBuildPhase.m
//  Sphere
//
//  Created by Jos Kuijpers on 8/28/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPXBuildPhase.h"

@implementation SPXBuildPhase

- (id)initWithCoder:(NSCoder *)coder
{
	self = [super init];
	if(self) {
		_name = [coder decodeObjectForKey:@"name"];
		_buildActionMask = [coder decodeObjectForKey:@"buildActionMask"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeObject:_name forKey:@"name"];
	[coder encodeObject:_buildActionMask forKey:@"buildActionMask"];
}

@end
