//
//  SRKFile.m
//  Sphere
//
//  Created by Jos Kuijpers on 25/02/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SRKFile.h"

@implementation SRKFile

@synthesize path=_path;

- (instancetype)initWithPath:(NSString *)path
{
	self = [super init];
	if(self) {
		_path = [path copy];
	}
	return self;
}

- (BOOL)save
{
	if(_path.length == 0)
		return NO;
	return [self saveToFile:_path];
}

- (BOOL)saveToFile:(NSString *)path
{
	return NO;
}

@end

void *srk_file_read_struct_proceed(NSData *data,
								   size_t size,
								   size_t *filePos)
{
	void *theStructure;

	if((*filePos + size) > data.length)
		return NULL;

	theStructure = (void *)((uint8_t *)[data bytes] + *filePos);
	*filePos += size;

	return theStructure;
}