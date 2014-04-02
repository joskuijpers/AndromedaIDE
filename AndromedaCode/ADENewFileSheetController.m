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

#import "ADENewFileSheetController.h"
#import "ADEProjectDocument.h"
#import "ACXProject.h"
#import "ACXGroup.h"
#import "ACXFileReference.h"

@interface ADENewFileSheetController ()
{
	NSArray *_templates;
}
@end

@implementation ADENewFileSheetController

- (id)init
{
    self = [super initWithWindowNibName:@"ADENewFileSheet"];
    if (self) {

		_templates = @[
					   @{
						   @"title" : [self descriptionForUTI:@"com.netscape.javascript-source"],
						   @"image" : [NSImage imageNamed:NSImageNameActionTemplate],
						   @"path" : @"Scripts",
						   @"fileTypes" : @[@"com.netscape.javascript-source"],
						   @"fileContent" : @""
						   },
					   @{
						   @"title" : [self descriptionForUTI:@"nl.jarvix.sphere.spriteset"],
						   @"image" : [NSImage imageNamed:NSImageNameBluetoothTemplate],
						   @"path" : @"SpriteSets",
						   @"fileTypes" : @[@"nl.jarvix.sphere.spriteset"],
						   @"fileContent" : @""
						   }
					   ];

    }
    return self;
}

- (NSString *)descriptionForUTI:(NSString *)UTI
{
	return [[NSWorkspace sharedWorkspace] localizedDescriptionForType:UTI];
}

- (void)windowDidLoad
{
    [super windowDidLoad];

	[self addObserver:self
		   forKeyPath:@"fileName"
			  options:0
			  context:nil];
}

#pragma mark - OutlineView data source

- (NSInteger)outlineView:(NSOutlineView *)outlineView
  numberOfChildrenOfItem:(id)item
{
	return (item != nil)?0:_templates.count;
}

- (id)outlineView:(NSOutlineView *)outlineView
objectValueForTableColumn:(NSTableColumn *)tableColumn
		   byItem:(id)item
{
	return item;
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
	return _templates[index];
}

#pragma mark - Responsive UI

- (void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(id)object
						change:(NSDictionary *)change
					   context:(void *)context
{
	self.nextButtonEnabled = _fileName.length > 0;
}

#pragma mark - Dismissing dialog and saving

- (void)dismiss:(id)sender
{
	NSError *error;
	NSURL *root, *file;
	ACXFileReference *fileReference;
	ACXProject *project;

	NSDictionary *template = _templates[_templateList.selectedRow];

	root = [[self.document project] projectDirectory];
	root = [root URLByAppendingPathComponent:template[@"path"]
										isDirectory:YES];
	file = [root URLByAppendingPathComponent:_fileName
								 isDirectory:NO];
	file = [file URLByAppendingPathExtension:[self extensionForUTI:template[@"fileTypes"][0]]];

	if(![[NSFileManager defaultManager] createDirectoryAtURL:root
								 withIntermediateDirectories:YES
												  attributes:0
													   error:&error]) {
		NSLog(@"Failed %@",error);
	}

	if(![template[@"fileContent"] writeToURL:file
								  atomically:YES
									encoding:NSUTF8StringEncoding
									   error:&error]) {
		NSLog(@"Failed %@",error);
	}

	// Add reference
	project = [self.document project];

	unsigned long dirLen = [[[project.projectDirectory standardizedURL] path] length]+1;
	NSString *relPath = [[[file standardizedURL] path] substringFromIndex:dirLen];

	fileReference = [ACXFileReference fileReferenceForPath:relPath];
	fileReference.lastKnownFileType = template[@"fileTypes"][0];

	// TODO correct location depending on selection
	[project.mainGroup.children addObject:fileReference];

	[self removeObserver:self
			  forKeyPath:@"fileName"];
	[super dismiss:sender];
}

- (NSString *)extensionForUTI:(NSString *)UTI
{
	return [[NSWorkspace sharedWorkspace] preferredFilenameExtensionForType:UTI];
}

@end
