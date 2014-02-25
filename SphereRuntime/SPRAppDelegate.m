//
//  SPRAppDelegate.m
//  SphereRuntime
//
//  Created by Jos Kuijpers on 8/27/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPRAppDelegate.h"
#import <JavaScriptCore/JavaScriptCore.h>

#import "SPRConsole.h"
#import "SphereRuntimeKit.h"

@implementation SPRAppDelegate {
	JSContext *_context;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	_context = [[JSContext alloc] init];

	// Create a simple text console for debugging
	_context[@"console"] = [[SPRConsole alloc] init];


	/// TESTTSSS
	NSString *projectPath;

	projectPath = @"/Users/jos/Documents/Jarvix/Production/Sphere/Games/SphereOriginal/Frogby";

#if 0
	SRKFileSGM *sgm;
	sgm = [[SRKFileSGM alloc] initWithPath:[projectPath stringByAppendingPathComponent:@"game.sgm"]];
	NSLog(@"SGM: %@",sgm);
#endif

#if 0
	SRKSpriteSet *rss;
	rss = [[SRKSpriteSet alloc] initWithPath:[projectPath stringByAppendingPathComponent:@"spritesets/sportcar.rss"]];
	NSLog(@"RSS: %@",rss);

	NSLog(@"RSS with path: %@",rss.path);
	NSLog(@"Images: %@",rss.images);
	int x = 0;
	for(SRKImage *img in rss.images) {
		[img saveToFile:[projectPath stringByAppendingPathComponent:[NSString stringWithFormat:@"spritesets/sportcar_%d.png",x]]];
		x++;
	}

	[rss.directions enumerateObjectsUsingBlock:^(SRKSpriteSetDirection *obj, NSUInteger idx, BOOL *stop) {
		NSLog(@"Direction %lu (%@):",(unsigned long)idx,obj.name);
		[obj.frames enumerateObjectsUsingBlock:^(SRKSpriteSetFrame *frame, NSUInteger idx2, BOOL *stop) {
			NSLog(@"\tFrame %lu: {image index: %d, delay: %d}",idx2,frame.index,frame.animationDelay);
		}];
	}];
#endif
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
	return YES;
}

@end
