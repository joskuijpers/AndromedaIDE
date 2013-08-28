//
//  SPHTarget.h
//  Sphere
//
//  Created by Jos Kuijpers on 8/28/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SXConfigurationList, SPXFileReference;

@interface SPXTarget : NSObject <NSCoding>

@property (copy) NSString *name;
@property (strong) NSMutableArray *buildPhases; // SPXBuildPhase
@property (strong) SXConfigurationList *configurationList;
@property (strong) SPXFileReference *productReference;
@property (copy) NSString *productName;
@property (copy) NSString *productInstallPath;

//- (void)build;
//- (void)clean;
//- (void)archive;

@end
