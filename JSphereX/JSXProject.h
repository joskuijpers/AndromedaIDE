//
//  JSXDocument.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/7/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class JSXFileMetaData, JSXProjectSplitViewController;

@interface JSXProject : NSDocument

@property (assign, nonatomic) IBOutlet JSXProjectSplitViewController *splitViewController;
@property (strong,readonly) JSXFileMetaData *metaData;

@end
