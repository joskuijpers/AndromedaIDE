//
//  STKBuilder.m
//  Sphere
//
//  Created by Jos Kuijpers on 8/27/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "STKBuilder.h"
#import "SXProject.h"

@interface STKBuilder()
{
	SXProject *_project;
}
@end

@implementation STKBuilder

- (id)initWithProject:(SXProject *)project
{
	self = [super init];
	if(self) {
		_project = project;
	}
	return self;
}

+ (STKBuilder *)builderForProject:(SXProject *)project
{
	return [[STKBuilder alloc] initWithProject:project];
}

- (void)build
{

}

- (void)run
{

}

- (void)archive
{
	
}

- (void)clean
{

}

@end
