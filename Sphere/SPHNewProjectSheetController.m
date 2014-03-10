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
 * THIS SOFTWARE IS PROVIDED BY APPLE INC. ``AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL APPLE INC. OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "SPHNewProjectSheetController.h"
#import "SPXProject.h"

@interface SPHNewProjectSheetController ()

@end

@implementation SPHNewProjectSheetController

- (id)init
{
    return [super initWithWindowNibName:@"SPHNewProjectSheet"];
}

- (void)windowDidLoad
{
    [super windowDidLoad];

	[self addObserver:self forKeyPath:@"productName" options:0 context:nil];
	[self addObserver:self forKeyPath:@"screenWidth" options:0 context:nil];
	[self addObserver:self forKeyPath:@"screenHeight" options:0 context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(id)object
						change:(NSDictionary *)change
					   context:(void *)context
{
	self.nextButtonEnabled = (_productName.length > 0
							  && _screenHeight.intValue > 0
							  && _screenWidth.intValue > 0);
}

- (void)dismiss:(id)sender
{
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	panel.canChooseDirectories = YES;
	panel.canChooseFiles = NO;
	panel.canCreateDirectories = YES;

	[panel beginSheetModalForWindow:self.window
				  completionHandler:^(NSInteger result)
	 {
		 if(result != NSOKButton)
			 return;

		 SPXProject *project = [self createProjectInDirectory:panel.URLs[0]];
		 NSDocumentController *dc;
		 dc = [NSDocumentController sharedDocumentController];
		 [dc openDocumentWithContentsOfURL:project.projectDirectory
								   display:YES
						 completionHandler:^(NSDocument *document, BOOL documentWasAlreadyOpen, NSError *error)
		  {
		  }];

		 [self closeWindow];
	 }];
}

- (void)closeWindow
{
	[self removeObserver:self forKeyPath:@"productName"];
	[self removeObserver:self forKeyPath:@"screenWidth"];
	[self removeObserver:self forKeyPath:@"screenHeight"];

	[super dismiss:self];
}

- (SPXProject *)createProjectInDirectory:(NSURL *)directory
{
	SPXProject *project;
	NSString *wrapper;
	NSError *error;

	wrapper = [NSString stringWithFormat:@"%@.sphereproj",_productName];
	directory = [directory URLByAppendingPathComponent:wrapper isDirectory:YES];

	if(![[NSFileManager defaultManager] createDirectoryAtURL:directory
							   withIntermediateDirectories:NO
												attributes:nil
														error:&error]) {
		NSLog(@"FAIL %@",error);
		// TODO Show error
		return nil;
	}

	project = [SPXProject projectWithName:_productName];
	project.projectDirectory = directory;

	project.attributes[kSPXProjectAttributeProductName] = _productName;
	project.attributes[kSPXProjectAttributeOrganizationName] = _organizationName;

	if(![project writeToFileSystem])
		NSLog(@"Failed to write project");

	return project;
}

@end
