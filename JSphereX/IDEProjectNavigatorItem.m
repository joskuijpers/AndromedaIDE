//
//  JSXProjectNavigatorItem.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/10/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

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
