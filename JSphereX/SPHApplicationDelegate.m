//
//  SPHApplicationDelegate.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/13/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPHApplicationDelegate.h"
#import "SPHPluginManager.h"
#import "SPHPlugin.h"

@implementation SPHApplicationDelegate

- (void)applicationWillFinishLaunching:(NSNotification *)notification
{
	_pluginManager = [[SPHPluginManager alloc] init];
	[_pluginManager loadAllPlugins];
//
//	NSLog(@"%@",[_pluginManager loadedPlugins]);
//
//	for(SPHPlugin *plugin in [_pluginManager loadedPlugins]) {
//		NSLog(@"%@",[plugin extensionDictionary]);
//	}
}

@end
