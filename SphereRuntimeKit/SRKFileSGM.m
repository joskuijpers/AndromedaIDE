//
//  SRKFileSGM.m
//  Sphere
//
//  Created by Jos Kuijpers on 24/02/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

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
