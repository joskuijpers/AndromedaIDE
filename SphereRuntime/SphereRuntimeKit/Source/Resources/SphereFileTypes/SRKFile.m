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
