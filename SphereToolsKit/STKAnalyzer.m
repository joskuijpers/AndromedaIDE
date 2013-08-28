//
//  STKAnalyzer.m
//  Sphere
//
//  Created by Jos Kuijpers on 8/29/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "STKAnalyzer.h"
#import "SXProject.h"
#import "STKAnalyzerDelegate.h"

@interface STKAnalyzer ()
{
	SXProject *_project;
}
@end

@implementation STKAnalyzer

- (id)initWithProject:(SXProject *)project
{
    self = [super init];
    if (self) {
        _project = project;
    }
    return self;
}

+ (STKAnalyzer *)analyzerForProject:(SXProject *)project
{
	return [[STKAnalyzer alloc] initWithProject:project];
}

- (void)analyzeProject
{

}

- (void)analyzeFile:(SXFile *)file
{

}

@end
