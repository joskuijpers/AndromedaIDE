//
//  JSXProjectNavigatorViewController.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/10/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SPXGroup;

@interface IDEProjectNavigatorViewController : NSViewController <NSOutlineViewDataSource, NSOutlineViewDelegate>

@property (weak,nonatomic) IBOutlet NSOutlineView *outlineView;

- (void)reload;
- (void)reloadGroup:(SPXGroup *)group;
- (SPXGroup *)selectedGroup;

@end
