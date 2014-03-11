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
 * THIS SOFTWARE IS PROVIDED BY APPLE INC. ``AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL APPLE INC. OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "SPRAppDelegate.h"

#import "SPRJSClass.h"
#import "SPRConsole.h"


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

typedef struct {
	int a;
	char b;
	long c;
	char *d;
} my_struct_t;

@protocol ClassB <L8Export>
- (my_struct_t)myMethod;
@end
@interface ClassB : ClassA <ClassB>
@end
@implementation ClassB
- (my_struct_t)myMethod
{
	NSLog(@"Just another method. Class is %@",[self className]);
	return (my_struct_t){1,'c',3,"hello"};
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

		_runtime[@"ClassA"] = [ClassA class];
		_runtime[@"ClassB"] = [ClassB class];

		load_bundle_script(_runtime, @"test");
	}];

}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
	return YES;
}

@end
