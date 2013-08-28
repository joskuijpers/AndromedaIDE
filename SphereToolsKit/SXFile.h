//
//  SXFile.h
//  Sphere
//
//  Created by Jos Kuijpers on 8/29/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SXProject, SPXFileReference;

@interface SXFile : NSObject

@property (strong) SXProject *project;

@property (strong,nonatomic) NSString *path;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *sourceTree;

- (instancetype)initWithProject:(SXProject *)project
			   spxFileReference:(SPXFileReference *)fileReference;

@end
