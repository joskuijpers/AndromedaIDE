//
//  JSXProjectNavigatorFileItem.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/13/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "IDEProjectNavigatorFileItem.h"

@implementation IDEProjectNavigatorFileItem

- (id)init
{
	self = [super init];
	if(self) {
		self.type = JSXProjectNavigatorItemFile;
	}
	return self;
}

- (NSString *)title
{
	return [[self.url path] lastPathComponent];
}

- (NSImage *)image
{
	if(super.image == nil)
		super.image = [[NSWorkspace sharedWorkspace] iconForFile:[self.url path]];
	return super.image;
}

@end
