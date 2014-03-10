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

#import "SPHPlugin.h"

@interface SPHPlugin()
{
	NSBundle *_bundle;
	NSObject<IDEPluginDelegate> *_instance;
	NSMutableArray *_extensions;
}
@end

@implementation SPHPlugin

- (id)initWithBundle:(NSBundle *)bundle instance:(NSObject<IDEPluginDelegate> *)instance
{
	self = [super init];
	if(self) {
		_bundle = bundle;
		_instance = instance;
	}
	return self;
}

- (NSArray *)discoverExtensions
{
	NSLog(@"Discover extensions of %@ with %@",self.name,self.extensionDictionary);
	return nil;
}

- (NSString *)name
{
	return [[[_bundle bundlePath] lastPathComponent] stringByDeletingPathExtension];
}

- (NSBundle *)bundle
{
	return _bundle;
}

- (NSObject<IDEPluginDelegate> *)instance
{
	return _instance;
}

- (NSDictionary *)extensionDictionary
{
	return [_instance extensions];
}

- (NSArray *)extensions
{
	return _extensions;
}

@end
