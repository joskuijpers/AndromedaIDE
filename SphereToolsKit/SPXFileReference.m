//
//  SPXFileReference.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/13/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPXFileReference.h"

@implementation SPXFileReference

+ (SPXFileReference *)fileReferenceForPath:(NSString *)path
{
	SPXFileReference *ref = [[self alloc] init];
	ref.path = [path copy];
	return ref;
}

#pragma mark - Encoding

- (id)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if(self) {
		_path = [coder decodeObjectForKey:@"path"];
		_lastKnownFileType = [coder decodeObjectForKey:@"lastKnownFileType"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[super encodeWithCoder:coder];

	[coder encodeObject:_path forKey:@"path"];
	[coder encodeObject:_lastKnownFileType forKey:@"lastKnownFileType"];
}

@end
