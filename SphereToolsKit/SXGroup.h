//
//  SXGroup.h
//  Sphere
//
//  Created by Jos Kuijpers on 8/29/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SXProject, SXSourceFile, SPXGroup;

@interface SXGroup : NSObject

@property (strong) SXProject *project;
@property (strong,nonatomic) NSString *pathRelativeToParent;
@property (strong,nonatomic) NSString *alias;

- (instancetype)initWithProject:(SXProject *)project
					   spxGroup:(SPXGroup *)group;

//- NSString *pathRelativeToProjectRoot
//- NSMutableArray *children // strong
//- NSMutableArray *members

- (SXGroup *)parentGroup;
- (BOOL)isRootGroup;
- (void)removeFromParentGroup; // below, def. NO
- (void)removeFromParentDeletingChildren:(BOOL)deletingChildren;

- (SXGroup *)addGroupWithPath:(NSString *)name;
- (void)addSourceFile:(SXSourceFile *)sourceFile;

@end
