//
//  SRKPlayList.m
//  Sphere
//
//  Created by Jos Kuijpers on 05/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SRKPlayList.h"

@implementation SRKPlayList {
	NSMutableArray *_filenames;
}

- (instancetype)initWithPath:(NSString *)path
{
	self = [super initWithPath:path];
	if(self) {
		@try {
			if(![self loadFileAtPath:self.path])
				return nil;
		} @catch (NSException *ex) {
			return nil;
		}
	}
	return self;
}

- (BOOL)loadFileAtPath:(NSString *)path
{
	NSString *fileContents;
	NSArray *lines;
	NSError *error = NULL;


	fileContents = [NSString stringWithContentsOfFile:path
									 encoding:NSUTF8StringEncoding
										error:&error];
	if(fileContents == nil) {
		NSLog(@"Error occurred during opening of file %@: %@",path,error);
		return NO;
	}

	lines = [fileContents componentsSeparatedByCharactersInSet:
			 [NSCharacterSet newlineCharacterSet]];

	_filenames = [NSMutableArray array];
	for(NSString *line in lines) {
		NSString *tline;

		tline = [line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		if(tline.length < 1 || [tline hasPrefix:@"#"])
			continue;

		[_filenames addObject:tline];
	}

	return YES;
}

- (void)appendSoundAtPath:(NSString *)path
{
	[_filenames addObject:path];
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<SRKPlayList>{}"];
}

@end
