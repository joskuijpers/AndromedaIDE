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
	NSObject<IDEPluginDelegate> *_instance;
	NSMutableArray *_extensions;
}
@end

@implementation SPHPlugin

- (id)initWithBundle:(NSBundle *)bundle instance:(NSObject<IDEPluginDelegate> *)instance
{
	self = [super init];
	if(self) {
		_bundle = bundle;
		_instance = instance;
	}
	return self;
}

- (NSArray *)discoverExtensions
{
	NSLog(@"Discover extensions of %@ with %@",self.name,self.extensionDictionary);
	return nil;
}

- (NSString *)name
{
	return [[[_bundle bundlePath] lastPathComponent] stringByDeletingPathExtension];
}

- (NSBundle *)bundle
{
	return _bundle;
}

- (NSObject<IDEPluginDelegate> *)instance
{
	return _instance;
}

- (NSDictionary *)extensionDictionary
{
	return [_instance extensions];
}

- (NSArray *)extensions
{
	return _extensions;
}

@end
