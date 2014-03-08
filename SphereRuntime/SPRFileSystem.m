//
//  SPRFileSystem.m
//  Sphere
//
//  Created by Jos Kuijpers on 07/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SPRFileSystem.h"

@implementation SPRFileSystem

+ (void)installIntoContext:(JSContext *)context
{
	context[@"FileSystem"] = [SPRFileSystem class];
}

+ (BOOL)createDirectoryAtPath:(NSString *)path
{
	NSLog(@"Create dir %@ (%@)",path,NSStringFromClass([self class]));
	return NO;
}

@end
