//
//  JSXProjectWindowController.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/9/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "JSXMainWindowController.h"
#import "JSXMainSplitViewController.h"

@interface JSXMainWindowController ()
{
	JSXMainSplitViewController *_mainSplitViewController;
}
@end

@implementation JSXMainWindowController

- (id)init
{
	return [super initWithWindowNibName:@"JSXProjectWindow"];
}

- (void)windowDidLoad
{
    [super windowDidLoad];

	_mainSplitViewController = [[JSXMainSplitViewController alloc] init];
	self.window.contentView = _mainSplitViewController.view;
}

@end
