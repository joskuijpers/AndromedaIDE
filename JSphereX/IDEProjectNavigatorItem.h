//
//  JSXProjectNavigatorItem.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/10/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	JSXProjectNavigatorItemProject,
	JSXProjectNavigatorItemGroup,
	JSXProjectNavigatorItemFolder,
	JSXProjectNavigatorItemFile
} JSXProjectNavigatorItemType;

@interface IDEProjectNavigatorItem : NSObject <NSPasteboardWriting,NSPasteboardReading>

@property (strong) NSURL *url;

@property (strong) NSString *title;
@property (strong) NSString *subTitle;
@property (strong) NSImage *image;

@property (assign) JSXProjectNavigatorItemType type;
@property (strong) NSMutableArray *children;

- (BOOL)isLeaf;
- (BOOL)isProject;

@end
