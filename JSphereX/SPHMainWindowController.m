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
	NSWindowController *_currentSheetController;
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

- (IBAction)newFile:(id)sender
{
	if(_currentSheetController != nil)
		return;

//	_currentSheetController = [[SPHNewFileWindowController alloc] init];
	[NSApp beginSheet:_currentSheetController.window
	   modalForWindow:[self.document windowForSheet]
		modalDelegate:self
	   didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:)
		  contextInfo:nil];
}

- (void)sheetDidEnd:(NSWindow *)sheet
		 returnCode:(NSInteger)returnCode
		contextInfo:(void *)contextInfo {
	_currentSheetController = nil;
	[sheet orderOut:self];
}

@end
