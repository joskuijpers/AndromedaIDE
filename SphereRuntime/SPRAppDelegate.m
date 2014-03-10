//
//  SPRAppDelegate.m
//  SphereRuntime
//
//  Created by Jos Kuijpers on 8/27/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

@import ObjectiveC.runtime;

#import "SPRAppDelegate.h"

#import "SPRJSClass.h"
#import "SPRConsole.h"
#import "SphereRuntimeKit.h"

@protocol ClassA <L8Export>
- (void)mySuperClassMethod;
@end
@interface ClassA : NSObject <ClassA>
@end
@implementation ClassA
- (void)mySuperClassMethod
{
	NSLog(@"Superclass calling. Class is %@",[self className]);
}
@end


@protocol ClassB <L8Export>
- (void)myMethod;
@end
@interface ClassB : ClassA <ClassB>
@end
@implementation ClassB
- (void)myMethod
{
	NSLog(@"Just another method. Class is %@",[self className]);
}
@end

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

//		_runtime[@"ClassA"] = [ClassA class];
		_runtime[@"ClassB"] = [ClassB class];

		load_bundle_script(_runtime, @"test");
	}];

}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
	return YES;
}

@end
