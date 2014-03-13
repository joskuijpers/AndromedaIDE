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
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
 * USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "IDEQuickLookPluginDelegate.h"

@implementation IDEQuickLookPluginDelegate

- (NSDictionary *)extensions
{
	return @{
			 @"IDEQuickLookEditor.Editor" : @{
					 @"id" : @"IDEQuickLookEditor.Editor",
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
					 @"id" : @"IDEQuickLookEditor.PDFInspector",
					 @"inspectorTitle" : @"PDF Properties",
					 @"fileDataType" : @"com.adobe.pdf",
					 @"sliceFile" : @"IDEQuickLookPDF", // TODO
					 @"controllerClass" : @"IDEQuickLookInspector",
					 @"point" : @"Sphere.IDE.FileInspector"
					 },
			 @"IDEQuickLookEditor.ImageInspector" : @{
					 @"id" : @"IDEQuickLookEditor.ImageInspector",
					 @"inspectorTitle" : @"Image Properties",
					 @"fileDataType" : @"public.image",
					 @"sliceFile" : @"IDEQuickLookImage", // TODO
					 @"controllerClass" : @"IDEQuickLookInspector",
					 @"point" : @"Sphere.IDE.FileInspector"
					 },
			 @"IDEQuickLookEditor.MenuDefinition.Editor" : @{
					 @"id" : @"IDEQuickLookEditor.MenuDefinition.Editor",
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
					 @"id" : @"IDEQuickLook.MenuDefinition.SubTest",
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
					 @"id" : @"IDEQuickLook.Command.Test",
					 @"point" : @"Sphere.IDE.Command",
					 @"name" : @"Test",
					 @"action" : @"test:"
					 }
			 };
}

@end
