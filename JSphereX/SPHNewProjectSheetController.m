//
//  SPHNewProjectSheetController.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/23/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

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
