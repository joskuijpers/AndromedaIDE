//
//  IDEJSPluginDelegate.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/13/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "IDEJavaScriptPluginDelegate.h"

@implementation IDEJavaScriptPluginDelegate

- (NSArray *)loadRules
{
	return @[
			 @{
				 @"kind" : @"plugin",
				 @"id" : @"nl.jarvix.sphere.ide.IDESourceCodeEditor"
				 }
			 ];
}

- (NSDictionary *)extensions
{
	return @{
			 @"IDEJavaScriptEditor.Editor" : @{
					 @"id" : @"IDEJavaScriptEditor.Editor",
					 @"editorClass" : @"IDESourceCodeEditor",//@"IDEJavaScriptEditor",
					 @"name" : @"JavaScript Document",
					 @"documentClass" : @"IDEJavaScriptDocument",
					 @"point" : @"Sphere.IDE.EditorDocument",
					 @"supportedFileType" : @[
							 @{ @"typeUTI" : @"com.netscape.javascript-source" },
							 ]
					 }
			 };
}

@end
