//
//  JSXFileProject.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/9/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "JSXFile.h"

@class JSXProjectMetaData;

@interface JSXProject : JSXFile

@property (strong) JSXProjectMetaData *metaData;
@property (strong) NSMutableArray *resourceSets;

@end
