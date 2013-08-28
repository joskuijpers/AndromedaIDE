//
//  SPXCopyFilesBuildPhase.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/13/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPXBuildPhase.h"

@interface SPXCopyFilesBuildPhase : SPXBuildPhase

@property (copy) NSString *destinationPath;
@property (assign) NSInteger destinationSubfolderSpecification;

@end
