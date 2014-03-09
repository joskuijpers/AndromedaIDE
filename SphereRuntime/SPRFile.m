//
//  SPRFile.m
//  Sphere
//
//  Created by Jos Kuijpers on 07/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SPRFile.h"
#import "NSString+SRKUtilities.h"

@implementation SPRFile {
	NSMutableDictionary *_storage;
}

@synthesize path=_path;

+ (void)installIntoContext:(L8Runtime *)context
{
	context[@"File"] = [SPRFile class];
}

- (instancetype)init
{
	self = [super init];
	if(self) {
		NSArray *arguments = [L8Runtime currentArguments];

		if(arguments.count >= 1) {
			_path = [[(L8Value *)arguments[0] toString] copy];

			// TODO: use some resource manager to find the correct path
			if(![self loadFileAtPath:_path])
				return nil;
		} else
			return nil; // TODO: exception instead?
	}
	return self;
}

- (BOOL)loadFileAtPath:(NSString *)path
{
	NSString *fileContents;
	NSError *error = NULL;
	NSArray *fileLines;
	NSCharacterSet *lineSplitSet;

	if(![[NSFileManager defaultManager] fileExistsAtPath:path]) {
		_storage = [[NSMutableDictionary alloc] init];
		return YES;
	}

	fileContents = [NSString stringWithContentsOfFile:path
											 encoding:NSUTF8StringEncoding
												error:&error];
	if(!fileContents) {
		NSLog(@"Failed to open file: %@",error);
		return NO;
	}

	// Split the lines
	lineSplitSet = [NSCharacterSet newlineCharacterSet];
	fileLines = [fileContents componentsSeparatedByCharactersInSet:lineSplitSet];

	// Create some storage
	_storage = [NSMutableDictionary dictionary];

	// For each line, find the key-value pair and store it
	for(NSString *line in fileLines) {
		NSString *tline, *key, *value;
		NSRange loc;

		tline = [line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		if(tline.length == 0 || [tline hasPrefix:@"#"])
			continue;

		loc = [tline rangeOfString:@"="];
		if(loc.location == NSNotFound)
			continue;

		key = [[tline substringToIndex:loc.location] srk_stringByTrimmingWhitespace];
		value = [[tline substringFromIndex:loc.location+1] srk_stringByTrimmingWhitespace];

		if(key.length == 0 || value.length == 0)
			continue;

		_storage[key] = value;
	}

	return YES;
}

- (BOOL)saveFileToPath:(NSString *)path
{
	NSMutableString *fileContents;
	NSError *error = NULL;

	fileContents = [NSMutableString string];

	[_storage enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSObject *obj, BOOL *stop) {
		[fileContents appendFormat:@"%@=%@\n",key,obj];
	}];

	/*if(![[NSFileManager defaultManager] fileExistsAtPath:path]) {
		return [[NSFileManager defaultManager] createFileAtPath:path
													   contents:_data
													 attributes:nil];
	}*/

	if(![fileContents writeToFile:path
					   atomically:YES
						 encoding:NSUTF8StringEncoding
							error:&error]) {
		NSLog(@"Failed to write file: %@",error);
		return NO;
	}

	return YES;
}

- (size_t)size
{
	return _storage.count;
}

- (NSString *)readKey:(NSString *)key withDefault:(NSString *)def
{
	NSString *val = _storage[key];
	return (val == nil)?def:val;
}

- (void)writeKey:(NSString *)key value:(NSString *)value
{
	_storage[key] = value;
}

- (void)flush
{
	[self saveFileToPath:_path];
}

- (void)close
{
	[self flush];
}

- (NSString *)md5hash
{
	return nil;
}

@end
