//
//  JSXProjectNavigatorItem.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/8/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
	JSXProjectNavigatorItemProject,
	JSXProjectNavigatorItemFolder,
	JSXProjectNavigatorItemGroup,
	JSXProjectNavigatorItemFile
} JSXProjectNavigatorItemType;

@interface JSXProjectNavigatorItem : NSObject

@property (strong) NSString *title;
@property (strong) NSString *subTitle;
@property (strong) NSImage *image;

@property (assign) JSXProjectNavigatorItemType type;

@property (strong) NSMutableArray *children;

- (BOOL)isLeafNode;
- (BOOL)isProject;

@end
