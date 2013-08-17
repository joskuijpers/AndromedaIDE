//
//  SPHApplicationDelegate.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/13/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPHApplicationDelegate.h"
#import "SPHPluginManager.h"
#import "SPHWelcomeWindowController.h"

@interface SPHApplicationDelegate()
{
	SPHWelcomeWindowController *_welcomeController;
}
@end

@implementation SPHApplicationDelegate

- (void)applicationWillFinishLaunching:(NSNotification *)notification
{
//	_pluginManager = [[SPHPluginManager alloc] init];
//	[_pluginManager loadAllPlugins];
}

- (IBAction)showWelcomeWindow:(id)sender
{
	if(!_welcomeController) {
		_welcomeController = [[SPHWelcomeWindowController alloc] init];
	}

	[_welcomeController.window makeKeyAndOrderFront:nil];
}

- (void)closeWelcomeWindow
{
	_welcomeController = nil;
}

@end
