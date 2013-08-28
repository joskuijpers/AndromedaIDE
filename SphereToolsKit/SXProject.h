//
//  SXProject.h
//  Sphere
//
//  Created by Jos Kuijpers on 8/29/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SXSourceFile, SXGroup, SXBuildConfiguration, SXTarget;

@interface SXProject : NSObject

@property (copy,nonatomic) NSString *filePath;
@property (copy,nonatomic) NSString *name;
@property (strong,nonatomic) SXGroup *mainGroup;

+ (SXProject *)projectWithFilePath:(NSString *)filePath; // path of project.spxproj

- (NSArray *)files; // SXSourceFile
- (SXGroup *)groupWithPathFromRoot:(NSString *)path;
- (SXGroup *)groupWithSourceFile:(SXSourceFile *)sourceFile;
- (SXGroup *)groupForGroupMember:(SXGroup *)group;

- (NSArray *)targets;
- (SXTarget *)targetWithName:(NSString *)name;
- (void)addTarget:(SXTarget *)target;
- (void)removeTarget:(SXTarget *)target;

- (NSDictionary *)configurations;
- (NSDictionary *)configurationWithName:(NSString *)name;
- (SXBuildConfiguration *)defaultConfiguration;
- (void)addConfiguration:(SXBuildConfiguration *)configuration;
- (void)removeConfiguration:(SXBuildConfiguration *)configuration;

- (void)save;

@end
