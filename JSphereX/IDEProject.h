//
//  JSXFileProject.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/9/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "IDEFile.h"

@class IDEProjectMetaData;

@interface IDEProject : IDEFile

@property (strong) IDEProjectMetaData *metaData;
@property (strong) NSMutableArray *resourceSets;

@end
