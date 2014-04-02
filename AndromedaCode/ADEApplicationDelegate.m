/*
 * Copyright (c) 2014 Jos Kuijpers. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
 * USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ADEApplicationDelegate.h"
#import "ADEDocumentController.h"
#import "ADEPluginManager.h"

#import "ADEWelcomeWindowController.h"
#import "ADENewProjectSheetController.h"

@interface ADEApplicationDelegate()
{
	ADEWelcomeWindowController *_welcomeController;
	NSWindowController *_currentSheetController;
}
@end

@implementation ADEApplicationDelegate

- (void)applicationWillFinishLaunching:(NSNotification *)notification
{
	(void)[[ADEDocumentController alloc] init];
//	_pluginManager = [[ADEPluginManager alloc] init];
//	[_pluginManager loadAllPlugins];
}

- (IBAction)showWelcomeWindow:(id)sender
{
	if(!_welcomeController)
		_welcomeController = [[ADEWelcomeWindowController alloc] init];
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

	_currentSheetController = [[ADENewProjectSheetController alloc] init];
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
