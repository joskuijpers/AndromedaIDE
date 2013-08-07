//
//  JSXDocument.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/7/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "JSXProject.h"
#import "NSString+Hashing.h"
#import "JSXFileMetaData.h"

NSString * const kJSXMetaDataProjectFormatVersionKey = @"ProjectFormatVersion";

@interface JSXProject()
{
	NSMutableDictionary *_resourceSets;
}

@property (strong) NSFileWrapper *documentFileWrapper;

@end

@implementation JSXProject

- (id)init
{
    self = [super init];
    if (self) {
		_metaData = [[JSXFileMetaData alloc] init];
		_resourceSets = [@{} mutableCopy];
    }
    return self;
}

- (NSString *)windowNibName
{
	return @"JSXProject";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
	[super windowControllerDidLoadNib:aController];
	// Add any code here that needs to be executed once the windowController has loaded the document's window.
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (BOOL)canAsynchronouslyWriteToURL:(NSURL *)url ofType:(NSString *)typeName forSaveOperation:(NSSaveOperationType)saveOperation
{
	return YES;
}

#pragma mark - Package support

- (NSFileWrapper *)fileWrapperOfType:(NSString *)typeName error:(NSError *__autoreleasing *)outError
{
	NSDictionary *rootContents;
	NSFileWrapper *metaDataWrapper;
	
	if(self.documentFileWrapper == nil) {
		NSLog(@"File wrapper must exist: project is saved before loading");
		
		return nil;
	}

	rootContents = [self.documentFileWrapper fileWrappers];
	
	metaDataWrapper = rootContents[@"MetaData.plist"];
	if(metaDataWrapper)
		[self.documentFileWrapper removeFileWrapper:metaDataWrapper];
	
	metaDataWrapper = [[NSFileWrapper alloc] initRegularFileWithContents:[_metaData fileData]];
	metaDataWrapper.preferredFilename = @"MetaData.plist";
	[self.documentFileWrapper addFileWrapper:metaDataWrapper];
	
	return self.documentFileWrapper;
}

- (BOOL)readFromFileWrapper:(NSFileWrapper *)fileWrapper
					 ofType:(NSString *)typeName
					  error:(NSError *__autoreleasing *)outError
{
	NSDictionary *rootContents;
	NSFileWrapper *resourcesWrapper, *metaDataWrapper;
	
	rootContents = [fileWrapper fileWrappers];
	
	metaDataWrapper = rootContents[@"MetaData.plist"];
	if(metaDataWrapper != nil) {
		NSData *data = [metaDataWrapper regularFileContents];
		_metaData = [[JSXFileMetaData alloc] initWithFileData:data];
	} else {
		// TODO: Corrupted notification
		return NO;
	}
	
	resourcesWrapper = rootContents[@"Resources"];
	if(resourcesWrapper != nil) {
		NSDictionary *resourcesContents = [resourcesWrapper fileWrappers];

		[resourcesContents enumerateKeysAndObjectsUsingBlock:^(NSString *name, NSFileWrapper *wrapper, BOOL *stop) {
			if(![wrapper isDirectory])
				return;

			if([self readResourceSetFromFileWrapper:wrapper
											  error:outError] == NO) {
				*stop = YES;
				return;
			}
		}];
		if(*outError != NULL)
			return NO;
		
	} else {
		// TODO: Corrupted notification
		return NO;
	}
	
	self.documentFileWrapper = fileWrapper;
	
	return YES;
}

- (BOOL)readResourceSetFromFileWrapper:(NSFileWrapper *)fileWrapper
								 error:(NSError *__autoreleasing *)outError
{
	NSDictionary *wrapperContents;
	NSMutableArray *files = [@[] mutableCopy];
	
	wrapperContents = [fileWrapper fileWrappers];
	[wrapperContents enumerateKeysAndObjectsUsingBlock:^(NSString *name, NSFileWrapper *file, BOOL *stop) {
		NSString *path = [@"Resources" stringByAppendingPathComponent:fileWrapper.filename];
		path = [path stringByAppendingPathComponent:file.filename];
		
		NSString *hash = [path stringByHashingWithMethod:JSXStringSHA1Hash];
		[files addObject:@{@"FileName":file.filename,@"Path":path,@"Hash":hash}];
	}];
	
	_resourceSets[fileWrapper.filename] = files;
	
	return YES;
}

@end
