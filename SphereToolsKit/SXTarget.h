//
//  SXTarget.h
//  Sphere
//
//  Created by Jos Kuijpers on 8/29/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SXProject, SPXFileReference, SXBuildConfiguration, SPXTarget;

@interface SXTarget : NSObject

@property (strong) SXProject *project;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *productName;
@property (strong,nonatomic) SPXFileReference *productReference;

//@private
- (instancetype)initWithProject:(SXProject *)project
					  spxTarget:(SPXTarget *)target;

- (NSString *)defaultConfigurationName; // Setter?
- (NSMutableArray *)members;

- (void)addDependency:(SXTarget *)target;
- (SXBuildConfiguration *)configurationWithName:(NSString *)name;
- (SXBuildConfiguration *)defaultConfiguration;

@end
