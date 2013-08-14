//
//  IDEJSPluginDelegate.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/13/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "IDEJavaScriptPluginDelegate.h"

@implementation IDEJavaScriptPluginDelegate

- (NSDictionary *)extensions
{
	return @{
			 @"Sphere.SphereKit.EditorDocument.JavaScriptEditor" : @{
					 @"editorClass" : @"IDEJavaScriptEditor",
					 @"name" : @"JavaScript Document",
					 @"documentClass" : @"IDEJavaScriptDocument",
					 @"point" : @"Sphere.IDE.EditorDocument",
					 @"supportedFileType" : @[
							 @{ @"typeUTI" : @"com.netscape.javascript-source" },
							 ]
					 },
			 @"IDEQuickLookEditor.EditorMenu" : @{
					 @"point" : @"Sphere.IDE.EditorMenu"
					 }
			 };
}

@end
