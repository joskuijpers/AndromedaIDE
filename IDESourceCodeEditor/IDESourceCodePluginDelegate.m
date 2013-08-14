//
//  IDESourceCodePluginDelegate.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/14/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "IDESourceCodePluginDelegate.h"

@implementation IDESourceCodePluginDelegate

- (NSDictionary *)extensions
{
	return @{
			 @"Sphere.IDE.EditorDocument.SourceCode" : @{
					 @"editorClass" : @"IDESourceCodeEditor",
					 @"point" : @"Sphere.IDE.EditorDocument",
					 @"documentClass" : @"IDESourceCodeDocument",
					 @"name" : @"Source Code Document",
					 @"editorMenuExtension" : @"IDESourceCodeEditor.MenuDefinition.Editor",
					 @"supportedFileType" : @[
							 @{
								 @"typeUTI" : @"public.source-code"
								 },
							 @{
								 @"typeUTI" : @"public.text"
								 }
							 ]
					 }
			 };
}

@end
