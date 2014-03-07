//
//  SPRRawFile.h
//  Sphere
//
//  Created by Jos Kuijpers on 07/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

@class SPRRawFile, SPRByteArray;

@protocol SPRRawFile <JSExport>

/// Path of the file
@property (strong,readonly) NSString *path;

/// Size of the file
@property (nonatomic,assign,readonly) size_t size;

/// Seek position within the file
@property (nonatomic,assign) size_t position;

/// Whether the file is writeable
@property (assign,readonly,getter=isWriteable) BOOL writable;

- (instancetype)init;

JSExportAs(read,
- (SPRByteArray *)readBytes:(size_t)len
);

JSExportAs(write,
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

@interface SPRRawFile : NSObject <SPRRawFile>

- (instancetype)initWithPath:(NSString *)path
				   writeable:(BOOL)writeable;

@end
