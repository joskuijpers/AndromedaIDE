//
//  JSXProjectWindowController.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/9/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPHMainWindowController.h"
#import "SPHMainSplitViewController.h"

@interface SPHMainWindowController ()
{
	SPHMainSplitViewController *_mainSplitViewController;
}
@end

@implementation SPHMainWindowController

- (id)init
{
	return [super initWithWindowNibName:@"SPHWorkspaceWindow"];
}

- (void)windowDidLoad
{
    [super windowDidLoad];

	_mainSplitViewController = [[SPHMainSplitViewController alloc] init];
	self.window.contentView = _mainSplitViewController.view;
}

@end
