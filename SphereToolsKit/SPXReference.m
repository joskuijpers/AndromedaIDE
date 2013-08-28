//
//  SPXReference.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/23/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPXReference.h"

@implementation SPXReference

- (id)initWithCoder:(NSCoder *)coder
{
	self = [super init];
	if(self) {
		_name = [coder decodeObjectForKey:@"name"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeObject:_name forKey:@"name"];
}

@end
