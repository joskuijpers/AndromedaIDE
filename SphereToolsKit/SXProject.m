//
//  SXProject.m
//  Sphere
//
//  Created by Jos Kuijpers on 8/29/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SXProject.h"

@implementation SXProject

+ (SXProject *)projectWithFilePath:(NSString *)filePath
{
	return nil;
}

- (NSArray *)files
{
	return nil;
}

- (SXGroup *)groupWithPathFromRoot:(NSString *)path
{
	return nil;
}

- (SXGroup *)groupWithSourceFile:(SXSourceFile *)sourceFile
{
	return nil;
}

- (SXGroup *)groupForGroupMember:(SXGroup *)group
{
	return nil;
}

- (NSArray *)targets
{
	return nil;
}

- (SXTarget *)targetWithName:(NSString *)name
{
	return nil;
}

- (void)addTarget:(SXTarget *)target
{
}

- (void)removeTarget:(SXTarget *)target
{
}

- (NSDictionary *)configurations
{
	return nil;
}

- (NSDictionary *)configurationWithName:(NSString *)name
{
	return nil;
}

- (SXBuildConfiguration *)defaultConfiguration
{
	return nil;
}

- (void)addConfiguration:(SXBuildConfiguration *)configuration
{

}

- (void)removeConfiguration:(SXBuildConfiguration *)configuration
{

}

- (void)save
{
	
}

@end
