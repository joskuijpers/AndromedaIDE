//
//  IDEWelcomeWindowController.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/17/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPHWelcomeWindowController.h"
#import "SPHApplicationDelegate.h"
#import "IDEHoverButton.h"

@interface SPHWelcomeWindowController ()
{
	NSArray *_recentItems;
}
@end

@implementation SPHWelcomeWindowController

- (id)init
{
    self =  [super initWithWindowNibName:@"SPHWelcomeWindow"];
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

	[(IDEHoverButton *)_closeButton setHoverImage:[NSImage imageNamed:@"nl.jarvix.sphere.image.welcome.close.over"]];
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
