//
//  JSXProjectWindowController.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/9/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "IDEMainWindowController.h"
#import "IDEMainSplitViewController.h"

@interface IDEMainWindowController ()
{
	IDEMainSplitViewController *_mainSplitViewController;
}
@end

@implementation IDEMainWindowController

- (id)init
{
	return [super initWithWindowNibName:@"IDEProjectWindow"];
}

- (void)windowDidLoad
{
    [super windowDidLoad];

	_mainSplitViewController = [[IDEMainSplitViewController alloc] init];
	self.window.contentView = _mainSplitViewController.view;
}

@end
