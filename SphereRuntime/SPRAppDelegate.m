//
//  SPRAppDelegate.m
//  SphereRuntime
//
//  Created by Jos Kuijpers on 8/27/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <objc/runtime.h>

#import "SPRAppDelegate.h"

#import "SPRJSClass.h"
#import "SPRConsole.h"
#import "SphereRuntimeKit.h"

@implementation SPRAppDelegate {
	L8Runtime *_runtime;
	NSMutableArray *_comboOptions;
}

void load_bundle_script(L8Runtime *context, NSString *name)
{
	@try {
		[context loadScriptAtPath:[[NSBundle mainBundle] pathForResource:name ofType:@"js"]];
	} @catch(id ex) {
		printf("[EXC ] %s\n",[[ex toString] UTF8String]);
	}
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	_runtime = [[L8Runtime alloc] init];


	[_runtime executeBlockInRuntime:^(L8Runtime *runtime) {
		spr_install_js_lib(_runtime);

		_runtime[@"console"] = [[SPRConsole alloc] init];


		load_bundle_script(_runtime, @"test");
	}];

}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
	return YES;
}

@end
