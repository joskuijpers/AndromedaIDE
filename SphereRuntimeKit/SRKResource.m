//
//  SRKResource.m
//  Sphere
//
//  Created by Jos Kuijpers on 05/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SRKResource.h"

@implementation SRKResource

@synthesize path=_path;

- (instancetype)initWithPath:(NSString *)path
{
	self = [super init];
	if(self) {
		_path = [path copy];
	}
	return self;
}

@end
