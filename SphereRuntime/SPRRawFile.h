//
//  SPRRawFile.h
//  Sphere
//
//  Created by Jos Kuijpers on 07/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SPRJSClass.h"

@class SPRRawFile, SPRByteArray;

@protocol SPRRawFile <L8Export>

/// Path of the file
@property (readonly) NSString *path;

/// Size of the file
@property (nonatomic,readonly) size_t size;

/// Seek position within the file
@property (nonatomic,assign) size_t position;

/// Whether the file is writeable
@property (readonly,getter=isWriteable) BOOL writable;

- (instancetype)init;

L8ExportAs(read,
- (SPRByteArray *)readBytes:(size_t)len
);

L8ExportAs(write,
- (void)writeByteArray:(SPRByteArray *)byteArray
);

/**
 * Writes all data to the output
 */
- (void)flush;

/**
 * Closes the file handle
 */
- (void)close;

/**
 * Creates an MD5 hash from the file
 */
- (NSString *)md5hash;

@end

@interface SPRRawFile : NSObject <SPRRawFile, SPRJSClass>

- (instancetype)initWithPath:(NSString *)path
				   writeable:(BOOL)writeable;

@end
