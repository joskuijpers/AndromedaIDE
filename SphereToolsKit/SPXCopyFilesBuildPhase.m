//
//  SPXCopyFilesBuildPhase.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/13/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPXCopyFilesBuildPhase.h"

@implementation SPXCopyFilesBuildPhase

- (id)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if(self) {
		_destinationPath = [coder decodeObjectForKey:@"destinationPath"];
		_destinationSubfolderSpecification = [coder decodeIntegerForKey:@"destinationSubfolderSpecification"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[super encodeWithCoder:coder];

	[coder encodeObject:_destinationPath forKey:@"destinationPath"];
	[coder encodeInteger:_destinationSubfolderSpecification forKey:@"destinationSubfolderSpecification"];
}

@end
