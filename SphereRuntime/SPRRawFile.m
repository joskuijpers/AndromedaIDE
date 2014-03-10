//
//  SPRRawFile.m
//  Sphere
//
//  Created by Jos Kuijpers on 07/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SPRRawFile.h"
#import "SPRByteArray.h"

@implementation SPRRawFile {
	NSMutableData *_data;
	size_t _position;
}

@synthesize size=_size, position=_position;
@synthesize path=_path, writable=_writable;

+ (void)installIntoContext:(L8Runtime *)context
{
	context[@"RawFile"] = [SPRRawFile class];
}

- (instancetype)init
{
	self = [super init];
	if(self) {
		NSArray *arguments = [L8Runtime currentArguments];

		if(arguments.count >= 1)
			_path = [arguments[0] toString];
		if(arguments.count >= 2)
			_writable = [arguments[1] toBool];

		// TODO handle _path in resource path blabla
		if(![self loadFileFromPath:_path])
			return nil;
	}
	return self;
}

- (instancetype)initWithPath:(NSString *)path writeable:(BOOL)writeable
{
	self = [super init];
	if(self) {
		_path = [path copy];
		_writable = writeable;

		if(![self loadFileFromPath:path])
			return nil;
	}
	return self;
}

- (BOOL)loadFileFromPath:(NSString *)path
{
	NSData *fileContents;
	NSError *error = NULL;

	if(![[NSFileManager defaultManager] fileExistsAtPath:path]) {
		_data = [[NSMutableData alloc] init];
		return YES;
	}

	fileContents = [NSData dataWithContentsOfFile:path
										  options:NSDataReadingMappedIfSafe
											error:&error];
	if(!fileContents) {
		NSLog(@"Failed to load SPRRawFile at path %@: %@",path,error);
		return NO;
	}

	_data = [fileContents mutableCopy];

	return YES;
}

- (BOOL)saveToFile:(NSString *)path
{
	NSError *error = NULL;

	if(![[NSFileManager defaultManager] fileExistsAtPath:path]) {
		return [[NSFileManager defaultManager] createFileAtPath:path
												contents:_data
											  attributes:nil];
	}

	if(![_data writeToFile:path
			   options:NSDataWritingAtomic
				 error:&error]) {
		NSLog(@"Failed to write SPRRawFile to %@: %@",path,error);
		return NO;
	}

	return YES;
}

- (SPRByteArray *)readBytes:(size_t)len
{
	NSData *data;

	data = [_data subdataWithRange:NSMakeRange(_position, len)];
	if(!data)
		return nil;

	_position += len;

	return [[SPRByteArray alloc] initWithData:data];
}

- (void)writeByteArray:(SPRByteArray *)byteArray
{
	uint8_t *dstBytes;
	const uint8_t *srcBytes;
	size_t writeSize, secondSize, srcSize;

	dstBytes = [_data mutableBytes];
	srcBytes = [[byteArray data] bytes];
	srcSize = [byteArray size];

	// First overwrite bytes
	writeSize = MIN(srcSize,_data.length - _position);
	memcpy(dstBytes + _position, srcBytes, writeSize);

	// Then append bytes
	secondSize = srcSize - writeSize;
	if(secondSize > 0) {
		[_data appendBytes:(srcBytes + writeSize)
					length:secondSize];
	}

	_position += srcSize;
}

- (void)flush
{
	if(![self saveToFile:_path])
		[[L8Value valueWithObject:@"Failed to write file"] throwValue];
}

- (void)close
{
	[self flush];
}

- (size_t)size
{
	return _data.length;
}

- (void)setPosition:(size_t)position
{
	_position = MIN(position,_data.length);
}

- (NSString *)md5hash
{
	return nil;
}

@end
