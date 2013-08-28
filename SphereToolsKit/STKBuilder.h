//
//  STKBuilder.h
//  Sphere
//
//  Created by Jos Kuijpers on 8/27/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SXProject;

@interface STKBuilder : NSObject

+ (STKBuilder *)builderForProject:(SXProject *)project;

- (void)build;
- (void)run;
- (void)archive;
- (void)clean;

@end
