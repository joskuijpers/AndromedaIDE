//
//  SPHPlugin.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/14/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPHPlugin.h"

@interface SPHPlugin()
{
	NSBundle *_bundle;
	id _instance;
}
@end

@implementation SPHPlugin

- (id)initWithBundle:(NSBundle *)bundle instance:(id)instance
{
	self = [super init];
	if(self) {
		_bundle = bundle;
		_instance = instance;
	}
	return self;
}

- (NSString *)name
{
	return [[[_bundle bundlePath] lastPathComponent] stringByDeletingPathExtension];
}

- (NSBundle *)bundle
{
	return _bundle;
}

- (id)instance
{
	return _instance;
}

@end
