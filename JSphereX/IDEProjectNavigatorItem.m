//
//  JSXProjectNavigatorItem.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/10/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "IDEProjectNavigatorItem.h"

@implementation IDEProjectNavigatorItem

- (id)init
{
	self = [super init];
	if(self) {
		_children = [NSMutableArray array];
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
		_type = JSXProjectNavigatorItemFile;
		_url = [NSURL URLWithString:_title];
	}
	return self;
}

- (BOOL)isLeaf
{
	return _type == JSXProjectNavigatorItemFile;
}

- (BOOL)isProject
{
	return _type == JSXProjectNavigatorItemProject;
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
