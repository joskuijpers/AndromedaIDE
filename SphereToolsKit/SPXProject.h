//
//  SPXProject.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/13/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPXGroup;

extern NSString * const kSPXProjectAttributeProductName;
extern NSString * const kSPXProjectAttributeOrganizationName;

@interface SPXProject : NSObject <NSCoding>

@property (strong) NSURL *projectDirectory;
@property (copy) NSString *name;
@property (strong) NSMutableDictionary *attributes;
@property (strong) SPXGroup *mainGroup;
@property (strong) SPXGroup *productGroup;
@property (strong) NSMutableArray *targets;

+ (SPXProject *)projectWithName:(NSString *)name;
+ (SPXProject *)projectWithURL:(NSURL *)url;
+ (BOOL)isProjectWrapperExtension:(NSString *)extension;

- (BOOL)writeToFileSystem;

//- (void)build;
//- (void)clean;
//- (void)archive;

@end
