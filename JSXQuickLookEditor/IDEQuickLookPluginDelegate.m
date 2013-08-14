//
//  IDEQuickLookDelegate.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/14/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "IDEQuickLookPluginDelegate.h"

@implementation IDEQuickLookPluginDelegate

- (NSDictionary *)extensions
{
	return @{
			 @"IDEQuickLookEditor.Editor" : @{
					 @"editorClass" : @"IDEJavaScriptEditor",
					 @"name" : @"Preview",
					 @"documentClass" : @"IDEJavaScriptDocument",
					 @"editorMenuExtension" : @"IDEQuickLookEditor.EditorMenu",
					 @"point" : @"Sphere.IDE.EditorDocument",
					 @"supportedFileType" : @[
							 @{ @"typeUTI" : @"public.data" },
							 @{ @"typeUTI" : @"com.apple.package" },
							 @{ @"typeUTI" : @"com.apple.iconset" }
							 ]
					 },
			 @"IDEQuickLookEditor.PDFInspector" : @{
					 @"inspectorTitle" : @"PDF Properties",
					 @"fileDataType" : @"com.adobe.pdf",
					 @"sliceFile" : @"IDEQuickLookPDF", // TODO
					 @"controllerClass" : @"IDEQuickLookInspector",
					 @"point" : @"Sphere.IDE.FileInspector"
					 },
			 @"IDEQuickLookEditor.ImageInspector" : @{
					 @"inspectorTitle" : @"Image Properties",
					 @"fileDataType" : @"public.image",
					 @"sliceFile" : @"IDEQuickLookImage", // TODO
					 @"controllerClass" : @"IDEQuickLookInspector",
					 @"point" : @"Sphere.IDE.FileInspector"
					 },
			 @"IDEQuickLookEditor.MenuDefinition.Editor" : @{
					 @"point" : @"Sphere.IDE.MenuDefinition",
					 @"name" : @"Editor",
					 @"menuItem" : @[
							 @{
								 @"type" : @"command",
								 @"commandIdentifier" : @"IDEQuickLook.Command.Test"
								 },
							 @{
								 @"type" : @"command",
								 @"commandIdentifier" : @"IDEQuickLook.Command.Test"
								 },
							 @{
								 @"type" : @"separator"
								 },
							 @{
								 @"type" : @"command",
								 @"commandIdentifier" : @"IDEQuickLook.Command.Test"
								 },
							 @{
								 @"type" : @"command",
								 @"commandIdentifier" : @"IDEQuickLook.Command.Test"
								 },
							 @{
								 @"type" : @"submenu",
								 @"submenuIdentifier" : @"IDEQuickLook.MenuDefinition.SubTest"
								 }
							 ]
					 },
			 @"IDEQuickLook.MenuDefinition.SubTest" : @{
					 @"point" : @"Sphere.IDE.MenuDefinition",
					 @"name" : @"Subtest",
					 @"menuItem" : @[
							 @{
								 @"type" : @"command",
								 @"commandIdentifier" : @"IDEQuickLook.Command.Test"
								 }
							 ]
					 },
			 @"IDEQuickLook.Command.Test" : @{
					 @"point" : @"Sphere.IDE.Command",
					 @"name" : @"Test",
					 @"action" : @"test:"
					 }
			 };
}

@end
