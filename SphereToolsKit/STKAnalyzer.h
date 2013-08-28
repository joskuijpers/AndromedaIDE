//
//  STKAnalyzer.h
//  Sphere
//
//  Created by Jos Kuijpers on 8/29/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol STKAnalyzerDelegate;
@class SXProject, SXFile;

@interface STKAnalyzer : NSObject

@property (weak) id<STKAnalyzerDelegate> delegate;

+ (STKAnalyzer *)analyzerForProject:(SXProject *)project;

- (void)analyzeProject;
- (void)analyzeFile:(SXFile *)file;

@end
