//
//  JSXDocument.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/7/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JSXDocument.h"

@class JSXProject;

@interface JSXProjectDocument : JSXDocument

@property (strong) JSXProject *project;

@end
