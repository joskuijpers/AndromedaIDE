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

#import "ADEWelcomeWindowController.h"
#import "ADEApplicationDelegate.h"
#import "ACKHoverButton.h"

@interface ADEWelcomeWindowController ()
{
	NSArray *_recentItems;
}
@end

@implementation ADEWelcomeWindowController

- (id)init
{
    self =  [super initWithWindowNibName:@"ADEWelcomeWindow"];
	if(self) {

		_recentItems = @[
						 @{
							 @"image":[NSImage imageNamed:@"nl.jarvix.sphere.image.project"],
							 @"name" : @"TestProject",
							 @"path" : @"~?TestProkect"
							 },
						 @{
							 @"image":[NSImage imageNamed:@"nl.jarvix.sphere.image.project"],
							 @"name" : @"TestProjectS",
							 @"path" : @"~?TestProkect"
							 }];
	}
	return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];

	[(ACKHoverButton *)_closeButton setHoverImage:[NSImage imageNamed:@"nl.jarvix.sphere.image.welcome.close.over"]];
}

- (IBAction)closeWindow:(id)sender
{
	[[NSApp delegate] closeWelcomeWindow];
}

#pragma mark - Outline View Data Source

- (NSInteger)outlineView:(NSOutlineView *)outlineView
  numberOfChildrenOfItem:(id)item
{
	if(item == nil)
		return [_recentItems count];
	return 0;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView
   isItemExpandable:(id)item
{
	return NO;
}

- (id)outlineView:(NSOutlineView *)outlineView
			child:(NSInteger)index
		   ofItem:(id)item
{
	return _recentItems[index];
}

- (id)outlineView:(NSOutlineView *)outlineView
objectValueForTableColumn:(NSTableColumn *)tableColumn
		   byItem:(id)item
{
	return item;
}

@end
