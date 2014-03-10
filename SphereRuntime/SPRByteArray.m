//
//  SPRByteArray.m
//  Sphere
//
//  Created by Jos Kuijpers on 07/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

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
