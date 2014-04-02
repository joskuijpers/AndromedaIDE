/*
 * Copyright (c) 2014 Jos Kuijpers. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
 * USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ADEPluginManager.h"
#import "ADEPlugin.h"
#import "ADEApplicationDelegate.h"

@interface ADEPluginManager()
{
	NSMutableArray *_loadedPlugins;
	NSMutableArray *_discoveredExtensions;
}
@end

@implementation ADEPluginManager

- (id)init
{
	self = [super init];
	if(self) {
		_loadedPlugins = [NSMutableArray array];
		_discoveredExtensions = [NSMutableArray array];
	}
	return self;
}

+ (instancetype)sharedPluginManager
{
	ADEApplicationDelegate *delegate;
	delegate = [[NSApplication sharedApplication] delegate];
	return delegate.pluginManager;
}

- (void)loadAllPlugins
{
	NSArray *bundles = [self allPluginBundles];

	for(NSString *bundle in bundles) {
		[self loadPluginAtPath:bundle];
	}

	// TODO: start-order?

	for(ADEPlugin *plugin in _loadedPlugins) {
		[self startPlugin:plugin];
	}
}

- (ACKPlugin *)pluginWithName:(NSString *)name
{
	for(ADEPlugin *plugin in _loadedPlugins) {
		if([plugin.name isEqualToString:name])
			return plugin;
	}
	return nil;
}

- (ACKPlugin *)pluginWithIdentifier:(NSString *)identifier
{
	for(ADEPlugin *plugin in _loadedPlugins) {
		if([[plugin.bundle bundleIdentifier] isEqualToString:identifier])
			return plugin;
	}
	return nil;
}

- (NSArray *)loadedPlugins
{
	return _loadedPlugins;
}

- (NSArray *)extensions
{
	return nil;
}

- (NSArray *)extensionPoints
{
	return nil;
}

#pragma mark - Private methods

- (void)loadPluginAtPath:(NSString *)path
{
	NSBundle *bundle;
	NSObject<ACKPluginDelegate> *instance;
	Class principalClass;
	ADEPlugin *plugin;

	bundle = [NSBundle bundleWithPath:path];
	principalClass = [bundle principalClass];

	if(!principalClass) {
		NSLog(@"Plugin %@ is not loadable.",[path lastPathComponent]);
		return;
	}

	if(![self isPrincipalClassValid:principalClass]) {
		NSLog(@"Plugin %@ is not valid.",[path lastPathComponent]);
		return;
	}

	instance = [[principalClass alloc] init];

	plugin = [[ADEPlugin alloc] initWithBundle:bundle
									  instance:instance];

	[_loadedPlugins addObject:plugin];
}

- (void)startPlugin:(ADEPlugin *)plugin
{
	NSArray *extensions;

	extensions = [plugin discoverExtensions];
	if(extensions)
		[_discoveredExtensions addObjectsFromArray:extensions];

	if([plugin.instance respondsToSelector:@selector(pluginDidFinishLoading)])
		[plugin.instance pluginDidFinishLoading];
}

- (BOOL)isPrincipalClassValid:(Class)principalClass
{
	if(![principalClass conformsToProtocol:@protocol(ACKPluginDelegate)])
		return NO;

	if(![principalClass instancesRespondToSelector:@selector(extensions)])
		return NO;

	return YES;
}

- (NSArray *)allPluginBundles
{
	NSMutableArray *pluginBundles = [NSMutableArray array];

	[[self searchPaths] enumerateObjectsUsingBlock:^(NSString *searchPath,
													 NSUInteger idx,
													 BOOL *stop) {
		NSDirectoryEnumerator *dirEnum;
		dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:searchPath];
		for(NSString *path in dirEnum) {
			if(![path.pathExtension isEqualToString:@"ideplugin"])
				continue;
			[pluginBundles addObject:[searchPath stringByAppendingPathComponent:path]];
		}
	}];

	return pluginBundles;
}

- (NSArray *)searchPaths
{
	return @[[[NSBundle mainBundle] builtInPlugInsPath]];
}

@end
