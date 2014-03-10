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
