//
//  SPXSourcesBuildPhase.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/13/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPXSourcesBuildPhase : NSObject

@property (strong) NSArray *files; // buildfile/fileref
@property (assign) BOOL runOnlyForDesploymentPostprocessing;

@end
