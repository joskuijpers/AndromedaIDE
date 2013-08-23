//
//  SPHApplicationDelegate.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/13/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPHApplicationDelegate.h"
#import "SPHDocumentController.h"
#import "SPHPluginManager.h"
#import "SPHWelcomeWindowController.h"

@interface SPHApplicationDelegate()
{
	SPHWelcomeWindowController *_welcomeController;
	NSWindowController *_currentSheetController;
}
@end

@implementation SPHApplicationDelegate

- (void)applicationWillFinishLaunching:(NSNotification *)notification
{
	(void)[[SPHDocumentController alloc] init];
//	_pluginManager = [[SPHPluginManager alloc] init];
//	[_pluginManager loadAllPlugins];
}

- (IBAction)showWelcomeWindow:(id)sender
{
	if(!_welcomeController)
		_welcomeController = [[SPHWelcomeWindowController alloc] init];
	[_welcomeController.window makeKeyAndOrderFront:nil];
}

- (void)closeWelcomeWindow
{
	_welcomeController = nil;
}

- (IBAction)newProject:(id)sender
{
	if(_currentSheetController != nil)
		return;

//	_currentSheetController = [[SPHNewProjectWindowController alloc] init];
	[NSApp beginSheet:_currentSheetController.window
	   modalForWindow:nil
		modalDelegate:self
	   didEndSelector:@selector(didEndSheet:returnCode:contextInfo:)
		  contextInfo:nil];
}

- (void)didEndSheet:(NSWindow *)sheet
		 returnCode:(NSInteger)returnCode
		contextInfo:(void *)contextInfo {
	_currentSheetController = nil;
}

@end
