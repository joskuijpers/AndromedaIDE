//
//  SPXProject.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/13/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPXProject.h"
#import "SPXGroup.h"

NSString * const kSPXProjectAttributeProductName = @"productName";
NSString * const kSPXProjectAttributeOrganizationName = @"organizationName";

@implementation SPXProject

+ (SPXProject *)projectWithName:(NSString *)name
{
	SPXProject *project = [[SPXProject alloc] init];

	project.name = [name copy];
	project.mainGroup = [SPXGroup groupWithName:@"root"];

	[project.mainGroup.children addObject:[SPXGroup groupWithName:name]];
	[project.mainGroup.children addObject:[SPXGroup groupWithName:@"Products"]];

	return project;
}

+ (SPXProject *)projectWithURL:(NSURL *)url
{
	SPXProject *project;

	project = [NSKeyedUnarchiver unarchiveObjectWithFile:[url path]];
	project.projectDirectory = [url URLByDeletingLastPathComponent];

	return project;
}

+ (BOOL)isProjectWrapperExtension:(NSString *)extension
{
	return [extension isEqualToString:@"sphereproj"];
}

- (BOOL)writeToFileSystem
{
	NSURL *spxpath = [_projectDirectory URLByAppendingPathComponent:@"project.spxproj"];
	return [NSKeyedArchiver archiveRootObject:self
									   toFile:spxpath.path];
}

#pragma mark - Encoding

- (id)initWithCoder:(NSCoder *)coder
{
	self = [super init];
	if(self) {
		_name = [coder decodeObjectForKey:@"name"];
		_attributes = [coder decodeObjectForKey:@"attributes"];
		_mainGroup = [coder decodeObjectForKey:@"mainGroup"];
		_productGroup = [coder decodeObjectForKey:@"productGroup"];
		_targets = [coder decodeObjectForKey:@"targets"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeObject:_name forKey:@"name"];
	[coder encodeObject:_attributes forKey:@"attributes"];
	[coder encodeObject:_mainGroup forKey:@"mainGroup"];
	[coder encodeObject:_productGroup forKey:@"productGroup"];
	[coder encodeObject:_targets forKey:@"targets"];
}

@end
