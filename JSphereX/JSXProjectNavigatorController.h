//
//  JSXProjectNavigatorController.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/8/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSXProjectNavigatorController : NSObject <NSOutlineViewDelegate>

@property (strong) NSMutableArray *items;
@property (weak) IBOutlet NSTreeController *treeController;

@end
