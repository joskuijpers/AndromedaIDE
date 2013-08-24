//
//  SPHNewFileSheetController.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/23/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPHNewFileSheetController.h"
#import "IDEProjectDocument.h"
#import "SPXProject.h"
#import "SPXGroup.h"
#import "SPXFileReference.h"

@interface SPHNewFileSheetController ()
{
	NSArray *_templates;
}
@end

@implementation SPHNewFileSheetController

- (id)init
{
    self = [super initWithWindowNibName:@"SPHNewFileSheet"];
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
	CFStringRef desc = UTTypeCopyDescription((__bridge CFStringRef)UTI);
	NSString *ret = [NSString stringWithString:(__bridge NSString *)desc];
	CFRelease(desc);
	return ret;
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
	SPXFileReference *fileReference;
	SPXProject *project;

	NSDictionary *template = _templates[_templateList.selectedRow];

	root = [[self.document project] projectDirectory];
	root = [root URLByAppendingPathComponent:template[@"path"]
										isDirectory:YES];
	file = [root URLByAppendingPathComponent:_fileName
								 isDirectory:NO];
	file = [file URLByAppendingPathExtension:[self extensionForType:template[@"fileTypes"][0]]];

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

	fileReference = [SPXFileReference fileReferenceForPath:relPath];
	fileReference.lastKnownFileType = template[@"fileTypes"][0];

	// TODO correct location depending on selection
	[project.mainGroup.children addObject:fileReference];

	[self removeObserver:self
			  forKeyPath:@"fileName"];
	[super dismiss:sender];
}

- (NSString *)extensionForType:(NSString *)type
{
	CFStringRef r = UTTypeCopyPreferredTagWithClass((__bridge CFStringRef)type, kUTTagClassFilenameExtension);
	return (__bridge NSString *)r;
}

@end
