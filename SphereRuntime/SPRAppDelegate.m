//
//  SPRAppDelegate.m
//  SphereRuntime
//
//  Created by Jos Kuijpers on 8/27/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPRAppDelegate.h"

#import "SPRConsole.h"
#import "SPRColor.h"
#import "SphereRuntimeKit.h"

@implementation SPRAppDelegate {
	JSContext *_context;
	NSMutableArray *_comboOptions;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	_context = [[JSContext alloc] initWithExceptionHandler];
	_context[@"console"] = [[SPRConsole alloc] init];
	
	_context[@"Color"] = [SPRColor class];

#if 0
	NSString *gamePath;
	gamePath = @"/Users/jos/Documents/Jarvix/Production/Sphere/Games/SphereOriginal/Scala World/";

	_context[@"RequireScript"] = ^(NSString *script) {
		NSString *p, *data;
		p = [gamePath stringByAppendingPathComponent:@"scripts"];
		p = [p stringByAppendingPathComponent:script];

		data = [NSString stringWithContentsOfFile:p
										 encoding:NSUTF8StringEncoding
											error:NULL];

		[[JSContext currentContext] evaluateScript:data];
	};
#endif


	NSString *main;
	main = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"js"]
									 encoding:NSUTF8StringEncoding
										error:NULL];
	@try {
		[_context evaluateScript:main];
	} @catch(id ex) {
		printf("[EXC ] %s\n",[[ex toString] UTF8String]);
	}



#if 0
	_comboOptions = [NSMutableArray array];
	NSArray *searchPaths;

	searchPaths = @[@"/Users/jos/Documents/Jarvix/Production/Sphere/Games/SphereOriginal/Scala World/maps/",
					@"/Users/jos/Documents/Jarvix/Production/Sphere/Games/SphereOriginal/Scala World/spritesets/",
					@"/Users/jos/Documents/Jarvix/Production/Sphere/Games/Resources/maps/",
					@"/Users/jos/Documents/Jarvix/Production/Sphere/Games/Resources/spritesets/"];

	for(NSString *xpath in searchPaths) {
		NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:xpath error:NULL];

		for(NSString *str in files) {
			if([str.pathExtension isEqualToString:@"rmp"]
			   || [str.pathExtension isEqualToString:@"rss"])
				[_comboOptions addObject:[xpath stringByAppendingPathComponent:str]];
		}
	}
#endif
}

- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox
{
	return _comboOptions.count;
}

- (void)comboBoxSelectionDidChange:(NSNotification *)notification
{
	NSComboBox *box;

	box = notification.object;

	NSString *path = _comboOptions[box.indexOfSelectedItem];

	if([path.pathExtension isEqualToString:@"rmp"]) {
		SRKMap *map = [[SRKMap alloc] initWithPath:path];
		_imageView.image = [map overviewRender];
	} else if([path.pathExtension isEqualToString:@"rss"]) {
		SRKSpriteSet *ss = [[SRKSpriteSet alloc] initWithPath:path];
		_imageView.image = [ss overviewRender];
	}
}

- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index
{
	return [_comboOptions[index] lastPathComponent];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
	return YES;
}

@end
