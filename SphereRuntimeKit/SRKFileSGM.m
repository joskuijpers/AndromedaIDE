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

#import "SRKFileSGM.h"
#import "NSString+SRKUtilities.h"

@implementation SRKFileSGM {
	NSDictionary *_data;
}

- (instancetype)initWithPath:(NSString *)path
{
	self = [super initWithPath:path];
	if(self) {
		_data = [self loadSimpleIniFileAtPath:self.path];
		if(_data == nil)
			return nil;

		// Put the data into the properties
		_author = _data[@"author"];
		_gameDescription = _data[@"description"];
		_name = _data[@"name"];

		_mainScript = _data[@"script"]?_data[@"script"]:@"main.js";

		NSUInteger width,height;
		width = [_data[@"screen_width"] unsignedIntValue];
		height = [_data[@"screen_height"] unsignedIntValue];
		_screenSize = NSMakeSize(width, height);
	}
	return self;
}

// Load the contents of a file with simple ini format
// that is: key=value, with no sections
- (NSDictionary *)loadSimpleIniFileAtPath:(NSString *)path
{
	NSMutableDictionary *storage;
	NSString *fileContents;
	NSArray *fileLines;
	NSError *error = NULL;
	NSCharacterSet *lineSplitSet;

	// Load the file contents
	fileContents = [NSString stringWithContentsOfFile:path
											 encoding:NSUTF8StringEncoding
												error:&error];
	if(fileContents == nil) {
		NSLog(@"Error occurred during opening of file %@: %@",path,error);
		return nil;
	}

	// Split the lines
	lineSplitSet = [NSCharacterSet newlineCharacterSet];
	fileLines = [fileContents componentsSeparatedByCharactersInSet:lineSplitSet];

	// Create some storage
	storage = [NSMutableDictionary dictionary];

	// For each line, find the key-value pair and store it
	for(NSString *line in fileLines) {
		NSString *tline, *key, *value;
		NSRange loc;

		tline = [line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		if(tline.length == 0 || [tline hasPrefix:@"#"])
			continue;

		loc = [tline rangeOfString:@"="];
		if(loc.location == NSNotFound) {
			NSLog(@"The SGM file '%@' contains an invalid line: '%@'. Skipping.",path,tline);
			continue;
		}

		key = [[tline substringToIndex:loc.location] srk_stringByTrimmingWhitespace];
		value = [[tline substringFromIndex:loc.location+1] srk_stringByTrimmingWhitespace];

		if(key.length == 0 || value.length == 0)
			continue;

		storage[key] = value;
	}

	return [storage copy];
}

- (BOOL)saveToFile:(NSString *)path
{
	NSMutableString *fileContents;
	NSError *error = NULL;

	fileContents = [NSMutableString string];

	[_data enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSObject *obj, BOOL *stop) {
		[fileContents appendFormat:@"%@=%@\n",key,obj];
	}];

	if(![fileContents writeToFile:path
				   atomically:NO
					 encoding:NSUTF8StringEncoding
						error:&error]) {
		NSLog(@"Failed to write SGM file to %@: %@",path,error);
		return NO;
	}

	return YES;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<SGM>{path: %@, author: '%@', description: '%@',"
								 @"name: '%@', script: '%@', screen size: %@}",
			self.path,_author,_gameDescription,_name,_mainScript,NSStringFromSize(_screenSize)];
}

@end
