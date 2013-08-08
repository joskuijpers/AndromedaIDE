//
//  JSXProjectNavigatorItem.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/8/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "JSXProjectNavigatorItem.h"

@implementation JSXProjectNavigatorItem

- (id)init
{
    self = [super init];
    if (self) {
        _children = [@[] mutableCopy];
    }
    return self;
}

- (BOOL)isLeafNode
{
	if(_type == JSXProjectNavigatorItemFile)
		return YES;
	return NO;
}

- (BOOL)isProject
{
	return _type == JSXProjectNavigatorItemProject;
}

@end
