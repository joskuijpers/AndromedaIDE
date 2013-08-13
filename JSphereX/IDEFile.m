//
//  JSXFile.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/7/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "IDEFile.h"

@interface IDEFile()
{
	NSData *_fileData;
}
@end

@implementation IDEFile

- (id)initWithFileData:(NSData *)fileData
{
	self = [super init];
	if(self) {
		_fileData = fileData;
	}
	return self;
}

- (NSData *)fileData
{
	return _fileData;
}

@end
