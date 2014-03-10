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

#import "IDEProjectNavigatorItem.h"
#import "SPXGroup.h"
#import "SPXFileReference.h"
#import "SPXProject.h"

@implementation IDEProjectNavigatorItem

- (id)init
{
	self = [super init];
	if(self) {
		_children = [NSMutableArray array];
	}
	return self;
}

- (id)initWithReference:(SPXReference *)reference
{
	self = [super init];
	if(self) {
		_children = [NSMutableArray array];
		_reference = reference;
		_title = reference.name;

		if([reference isKindOfClass:[SPXGroup class]]) {
			_type = IDEProjectNavigatorItemGroup;
			_image = [NSImage imageNamed:@"nl.jarvix.sphere.image.navgroup"];

			for(SPXReference *child in [(SPXGroup *)reference children])
				[_children addObject:[IDEProjectNavigatorItem itemWithReference:child]];

		} else {
			_type = IDEProjectNavigatorItemFile;
			_url = [NSURL URLWithString:[(SPXFileReference *)reference path]
						  relativeToURL:nil];
			// TODO
			_image = [[NSWorkspace sharedWorkspace] iconForFile:_url.path];
		}
	}
	return self;
}

- (id)initWithProject:(SPXProject *)project
{
	self = [super init];
	if(self) {
		_children = [NSMutableArray array];
		_reference = project.mainGroup;
		_title = project.name;
		_subTitle = @"SubTitle";
		_type = IDEProjectNavigatorItemProject;
		_image = [NSImage imageNamed:@"nl.jarvix.sphere.image.project"];

		for(SPXReference *child in [project.mainGroup children])
			[_children addObject:[IDEProjectNavigatorItem itemWithReference:child]];
	}
	return self;
}

- (id)initWithPasteboardPropertyList:(id)propertyList ofType:(NSString *)type
{
	self = [self init];
	if(self) {
		id o = [NSPropertyListSerialization propertyListFromData:propertyList
										 mutabilityOption:0
												   format:NULL
										 errorDescription:NULL];
		NSLog(@"%@ %@ %@",NSStringFromSelector(_cmd),o,[o className]);
		_title = o;
		_type = IDEProjectNavigatorItemFile;
		_url = [NSURL URLWithString:_title];
	}
	return self;
}

+ (IDEProjectNavigatorItem *)itemWithReference:(SPXReference *)reference;
{
	return [[self alloc] initWithReference:reference];
}

+ (IDEProjectNavigatorItem *)itemWithProject:(SPXProject *)project
{
	return [[self alloc] initWithProject:project];
}

- (NSArray *)writableTypesForPasteboard:(NSPasteboard *)pasteboard
{
	return [_url writableTypesForPasteboard:pasteboard];
}

+ (NSArray *)readableTypesForPasteboard:(NSPasteboard *)pasteboard
{
	return [NSURL readableTypesForPasteboard:pasteboard];
}

- (id)pasteboardPropertyListForType:(NSString *)type
{
	return [_url pasteboardPropertyListForType:type];
}

@end
