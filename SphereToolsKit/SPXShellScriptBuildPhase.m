//
//  SPXShellScriptBuildPhase.m
//  Sphere
//
//  Created by Jos Kuijpers on 8/29/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPXShellScriptBuildPhase.h"

@implementation SPXShellScriptBuildPhase

- (id)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if(self) {
		_shellPath = [coder decodeObjectForKey:@"shellPath"];
		_shellScript = [coder decodeObjectForKey:@"shellScript"];
		_inputPaths = [coder decodeObjectForKey:@"inputPaths"];
		_outputPaths = [coder decodeObjectForKey:@"outputPaths"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[super encodeWithCoder:coder];
	
	[coder encodeObject:_shellPath forKey:@"shellPath"];
	[coder encodeObject:_shellScript forKey:@"shellScript"];
	[coder encodeObject:_inputPaths forKey:@"inputPaths"];
	[coder encodeObject:_outputPaths forKey:@"outputPaths"];
}

@end
