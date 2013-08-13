//
//  SPXCopyFilesBuildPhase.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/13/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPXCopyFilesBuildPhase : NSObject

@property (strong) NSString *name;
@property (strong) NSString *destinationPath;
@property (strong) NSArray *files; // buildfile/fileref
@property (assign) BOOL runOnlyForDesploymentPostprocessing;
@property (assign) NSUInteger destinationSubfolderSpecification;

@end
