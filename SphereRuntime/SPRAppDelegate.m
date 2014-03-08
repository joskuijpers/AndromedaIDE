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
	JSContext *_context;
	NSMutableArray *_comboOptions;
}

void load_bundle_script(JSContext *context, NSString *name)
{
	NSString *main;
	main = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"js"]
									 encoding:NSUTF8StringEncoding
										error:NULL];
	@try {
		[context evaluateScript:main];
	} @catch(id ex) {
		printf("[EXC ] %s\n",[[ex toString] UTF8String]);
	}
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	_context = [[JSContext alloc] initWithExceptionHandler];
	spr_install_js_lib(_context);

	_context[@"console"] = [[SPRConsole alloc] init];








	load_bundle_script(_context, @"test");
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
	return YES;
}

@end
