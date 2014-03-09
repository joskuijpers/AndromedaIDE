//
//  SPRByteArray.h
//  Sphere
//
//  Created by Jos Kuijpers on 07/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SPRJSClass.h"

@class SPRByteArray;

@protocol SPRByteArray <L8Export>

- (instancetype)init;

L8ExportAs(concat,
- (SPRByteArray *)byteArrayByAppendingByteArray:(SPRByteArray *)byteArray
);

L8ExportAs(slice,
- (SPRByteArray *)subArrayWithStart:(size_t)start end:(size_t)end
);

- (size_t)size;
- (NSString *)makeString;

/**
 * Creates an MD5 hash from the byte array
 */
- (NSString *)md5hash;

@end

@interface SPRByteArray : NSObject <SPRByteArray, SPRJSClass>

- (instancetype)initWithData:(NSData *)data;
- (NSMutableData *)data;

@end
