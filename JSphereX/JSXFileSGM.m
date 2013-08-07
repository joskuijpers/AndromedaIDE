//
//  JSXGameInfoFile.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/7/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "JSXFileSGM.h"

@implementation JSXFileSGM

- (id)initWithFileData:(NSData *)fileData
{
	self = [super initWithFileData:nil];
	if(self) {
		NSString *dataString = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
		[self loadDataFromString:dataString];
	}
	return self;
}

- (void)loadDataFromString:(NSString *)string
{
	NSMutableDictionary *dictionary = [@{} mutableCopy];
	
	for(NSString *line in [string componentsSeparatedByString:@"\n"]) {
		NSString *trimmedLine = [line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		if([trimmedLine length] < 1)
			continue;

		NSArray *split = [trimmedLine componentsSeparatedByString:@"="];
		if([split count] != 2) {
			@throw [NSException exceptionWithName:@"InvalidFileException"
										   reason:@"Game info file was corrupted"
										 userInfo:nil];
		}
		
		dictionary[split[0]] = split[1];
	}

	[self loadDataFromDictionary:dictionary];
}

- (void)loadDataFromDictionary:(NSDictionary *)dictionary
{
	if([dictionary[@"author"] length])
		_author = dictionary[@"author"];
	
	if([dictionary[@"description"] length])
		_gameDescription = dictionary[@"description"];
	
	if([dictionary[@"name"] length])
		_name = dictionary[@"name"];
	
	_screenHeight = dictionary[@"screen_height"];
	_screenWidth = dictionary[@"screen_width"];
	
	if([dictionary[@"script"] length])
		_script = dictionary[@"script"];
}

- (NSDictionary *)toDictionary
{
	NSMutableDictionary *dictionary = [@{} mutableCopy];
	
	if(_author)
		dictionary[@"author"] = _author;
	
	if(_gameDescription)
		dictionary[@"description"] = _gameDescription;
	
	if(_name)
		dictionary[@"name"] = _name;
	
	dictionary[@"screen_height"] = _screenHeight;
	dictionary[@"screen_width"] = _screenWidth;
	
	if(_script)
		dictionary[@"script"] = _script;
	
	return dictionary;
}

- (NSString *)toString
{
	NSDictionary *dictionary = [self toDictionary];
	NSMutableArray *lines = [@[] mutableCopy];
	
	[dictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSObject *obj, BOOL *stop) {
		[lines addObject:[NSString stringWithFormat:@"%@=%@",key,obj]];
	}];
	
	return [lines componentsJoinedByString:@"\n"];
}

- (NSData *)fileData
{
	return [[self toString] dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSSize)screenSize
{
	return NSMakeSize([_screenWidth integerValue], [_screenHeight integerValue]);
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@{author: %@, description: %@, name: %@, screen size: %@, script: %@}",[super description],_author,_gameDescription,_name,NSStringFromSize(self.screenSize),_script];
}

@end
