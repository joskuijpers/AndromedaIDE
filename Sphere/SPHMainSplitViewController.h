//
//  JSXMainSplitViewController.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/9/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class IDEProjectNavigatorViewController;

@interface SPHMainSplitViewController : NSViewController

@property (weak,nonatomic) IBOutlet NSSplitView *splitView;

// - (IDEEditor *)currentEditor;
// - (NSArray *)navigators;
// TODO: make IDEProjectNavigator
- (IDEProjectNavigatorViewController *)projectNavigator;

@end
