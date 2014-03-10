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

#import "SPRByteArray.h"

@implementation SPRByteArray {
	NSMutableData *_data;
}

+ (void)installIntoContext:(L8Runtime *)context
{
	context[@"ByteArray"] = [SPRByteArray class];
}

- (instancetype)init
{
	self = [super init];
	if(self) {
		NSArray *arguments = [L8Runtime currentArguments];
		if(arguments.count >= 1) {
			L8Value *val = arguments[0];
			if([val isNumber]) {
				int size = [[val toNumber] intValue];
				_data = [[NSMutableData alloc] initWithLength:size];
			} else {
				NSString *value = [val toString];
				_data = [[value dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
			}
		}
	}
	return self;
}

- (instancetype)initWithData:(NSData *)data
{
	self = [super init];
	if(self) {
		_data = [data mutableCopy];
	}
	return self;
}

- (NSMutableData *)data
{
	return _data;
}

- (SPRByteArray *)byteArrayByAppendingByteArray:(SPRByteArray *)byteArray
{
	NSMutableData *data = [_data mutableCopy];
	[data appendData:[byteArray data]];
	if(data)
		return [[SPRByteArray alloc] initWithData:data];
	return nil;
}

- (SPRByteArray *)subArrayWithStart:(size_t)start end:(size_t)end
{
	NSData *data;
	@try {
		data = [_data subdataWithRange:NSMakeRange(start, end-start+1)];
	} @catch(id) {
		return nil;
	}
	return [[SPRByteArray alloc] initWithData:data];
}

- (size_t)size
{
	return _data.length;
}

- (NSString *)makeString
{
	return [[NSString alloc] initWithData:_data
								 encoding:NSUTF8StringEncoding];
}

- (NSString *)md5hash
{
	return nil;
}

@end
