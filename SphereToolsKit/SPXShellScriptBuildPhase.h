//
//  SPXShellScriptBuildPhase.h
//  Sphere
//
//  Created by Jos Kuijpers on 8/29/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPXBuildPhase.h"

@interface SPXShellScriptBuildPhase : SPXBuildPhase

@property (copy) NSString *shellPath;
@property (copy) NSString *shellScript;
@property (strong) NSMutableArray *inputPaths;
@property (strong) NSMutableArray *outputPaths;

@end
