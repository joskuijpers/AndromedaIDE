//
//  SXGroup.m
//  Sphere
//
//  Created by Jos Kuijpers on 8/29/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SXGroup.h"

@implementation SXGroup

- (instancetype)initWithProject:(SXProject *)project
					   spxGroup:(SPXGroup *)group
{
	return nil;
}

- (SXGroup *)parentGroup
{
	return nil;
}

- (BOOL)isRootGroup
{
	return NO;
}

- (void)removeFromParentGroup
{
	return [self removeFromParentDeletingChildren:NO];
}

- (void)removeFromParentDeletingChildren:(BOOL)deletingChildren
{

}

- (SXGroup *)addGroupWithPath:(NSString *)name
{
	// relative
	return nil;
}

- (void)addSourceFile:(SXSourceFile *)sourceFile
{

}

@end
