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
