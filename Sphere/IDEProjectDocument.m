//
//  JSXDocument.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/7/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "IDEProjectDocument.h"
#import "SPHMainWindowController.h"
#import "SPXProject.h"

@interface IDEProjectDocument()
{
	SPHMainWindowController *_windowController;
}
@end

@implementation IDEProjectDocument

- (void)makeWindowControllers
{
	_windowController = [[SPHMainWindowController alloc] init];

	[self addWindowController:_windowController];
}

+ (BOOL)autosavesInPlace
{
    return YES; // TODO: NO
}

- (BOOL)canAsynchronouslyWriteToURL:(NSURL *)url ofType:(NSString *)typeName forSaveOperation:(NSSaveOperationType)saveOperation
{
	return YES;
}

#pragma mark - Package support

- (BOOL)readFromURL:(NSURL *)url
			 ofType:(NSString *)typeName
			  error:(NSError *__autoreleasing *)outError
{
	_project = [SPXProject projectWithURL:[url URLByAppendingPathComponent:@"project.spxproj"]];

	return YES;
}

@end
