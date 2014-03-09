//
//  SPRCompatibility16.m
//  Sphere
//
//  Created by Jos Kuijpers on 08/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SPRCompatibility16.h"

@implementation SPRCompatibility16

+ (void)makeContextCompatible:(L8Runtime *)context
{
	// Load the shim file
	NSString *main;
	main = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sphere16"
																			  ofType:@"js"]
									 encoding:NSUTF8StringEncoding
										error:NULL];
	@try {
		[context evaluateScript:main];
	} @catch(id ex) {
		printf("[EXC ] %s\n",[[ex toString] UTF8String]);
	}

	printf("[TODO] Create path resolving withing gamefolder\n");
	NSString *gamePath = @"/Users/jos/Documents/Jarvix/Production/Sphere/Games/SphereOriginal/Scala World/";

	// Add functions we can't put in a shim
	context[@"RequireScript"] = ^(NSString *script) {
		NSString *p, *data;
		p = [gamePath stringByAppendingPathComponent:@"scripts"];
		p = [p stringByAppendingPathComponent:script];

		data = [NSString stringWithContentsOfFile:p
										 encoding:NSUTF8StringEncoding
											error:NULL];

		[[L8Runtime currentRuntime] evaluateScript:data];
	};

}

@end
