//
//  SRKFile.m
//  Sphere
//
//  Created by Jos Kuijpers on 25/02/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SRKFile.h"

@implementation SRKFile

- (BOOL)save
{
	if(self.path.length == 0)
		return NO;
	return [self saveToFile:self.path];
}

- (BOOL)saveToFile:(NSString *)path
{
	return NO;
}

@end

void *srk_file_read_struct(NSData *data,
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

BOOL srk_file_read_byte(NSData *data, size_t *filePos, uint8_t *value)
{
	uint8_t *ptr;

	ptr = srk_file_read_struct(data, sizeof(uint8_t), filePos);
	if(ptr != NULL) {
		*value = *ptr;
		return YES;
	}

	return NO;
}

BOOL srk_file_read_word(NSData *data, size_t *filePos, uint16_t *value)
{
	uint16_t *ptr;

	ptr = srk_file_read_struct(data, sizeof(uint16_t), filePos);
	if(ptr != NULL) {
		*value = *ptr;
		return YES;
	}

	return NO;
}

BOOL srk_file_read_dword(NSData *data, size_t *filePos, uint32_t *value)
{
	uint32_t *ptr;

	ptr = srk_file_read_struct(data, sizeof(uint32_t), filePos);
	if(ptr != NULL) {
		*value = *ptr;
		return YES;
	}

	return NO;
}

NSString *srk_file_read_string(NSData *data, size_t *filePos)
{
	uint16_t length;
	NSData *strData;

	if(!srk_file_read_word(data, filePos, &length))
		return nil;

	strData = [data subdataWithRange:NSMakeRange(*filePos, length)];
	*filePos += length;

	return [[NSString alloc] initWithData:strData
								 encoding:NSUTF8StringEncoding];
}
