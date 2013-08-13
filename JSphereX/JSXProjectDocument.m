//
//  JSXDocument.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/7/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "JSXProjectDocument.h"

#import "JSXMainWindowController.h"

//#import "NSString+Hashing.h"

#import "JSXProjectMetaData.h"
#import "JSXProject.h"

@interface JSXProjectDocument()
{
	NSFileWrapper *_documentFileWrapper; // To model
	JSXMainWindowController *_windowController;
}
@end

@implementation JSXProjectDocument

- (void)makeWindowControllers
{
	_windowController = [[JSXMainWindowController alloc] init];
	
	[self addWindowController:_windowController];
}

#pragma mark - Package support

- (NSFileWrapper *)fileWrapperOfType:(NSString *)typeName
							   error:(NSError *__autoreleasing *)outError
{
	// All code to model
	NSDictionary *rootContents;
	NSFileWrapper *metaDataWrapper;
	
	if(_documentFileWrapper == nil) {
		NSLog(@"File wrapper must exist: project is saved before loading");
		
		return nil;
	}

	rootContents = [_documentFileWrapper fileWrappers];
	
	metaDataWrapper = rootContents[@"MetaData.plist"];
	if(metaDataWrapper)
		[_documentFileWrapper removeFileWrapper:metaDataWrapper];
	
	metaDataWrapper = [[NSFileWrapper alloc] initRegularFileWithContents:[_project.metaData fileData]];
	metaDataWrapper.preferredFilename = @"MetaData.plist";
	[_documentFileWrapper addFileWrapper:metaDataWrapper];
	
	return _documentFileWrapper;
}

- (BOOL)readFromFileWrapper:(NSFileWrapper *)fileWrapper
					 ofType:(NSString *)typeName
					  error:(NSError *__autoreleasing *)outError
{
	NSDictionary *rootContents;
	NSFileWrapper *resourcesWrapper, *metaDataWrapper;
	
	rootContents = [fileWrapper fileWrappers];
	
	_project = [[JSXProject alloc] init];
	
	metaDataWrapper = rootContents[@"MetaData.plist"];
	if(metaDataWrapper != nil) {
		NSData *data = [metaDataWrapper regularFileContents];
		_project.metaData = [[JSXProjectMetaData alloc] initWithFileData:data];
	} else
		return NO;
	
	resourcesWrapper = rootContents[@"Resources"];
	if(resourcesWrapper != nil) {
		NSDictionary *resourcesContents = [resourcesWrapper fileWrappers];

		for(NSFileWrapper *wrapper in [resourcesContents allValues]) {
			if(![wrapper isDirectory])
				continue;
			
			if([self readResourceSetFromFileWrapper:wrapper
											  error:outError] == NO)
				return NO;
		}
		
	} else
		return NO;
	
	_documentFileWrapper = fileWrapper;
	
	return YES;
}

- (BOOL)readResourceSetFromFileWrapper:(NSFileWrapper *)fileWrapper
								 error:(NSError *__autoreleasing *)outError
{
	/*NSDictionary *wrapperContents;
	NSMutableArray *files = [@[] mutableCopy];
	
	wrapperContents = [fileWrapper fileWrappers];
	for(NSFileWrapper *file in [wrapperContents allValues]) {
		NSString *path = [@"Resources" stringByAppendingPathComponent:fileWrapper.filename];
		path = [path stringByAppendingPathComponent:file.filename];
		
		NSString *hash = [path stringByHashingWithMethod:JSXStringSHA1Hash];
		[files addObject:@{@"FileName":file.filename,@"Path":path,@"Hash":hash}];
	};
	
	_resourceSets[fileWrapper.filename] = files;
	*/
	return YES;
}

@end
