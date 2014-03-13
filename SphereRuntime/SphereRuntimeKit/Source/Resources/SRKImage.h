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
#include <stdint.h>

typedef struct {
	uint8_t red;
	uint8_t green;
	uint8_t blue;
} srk_rgb_t;

typedef struct {
	uint8_t red;
	uint8_t green;
	uint8_t blue;
	uint8_t alpha;
} srk_rgba_t;

typedef struct {
#ifdef __LITTLE_ENDIAN__
	uint8_t blue;
	uint8_t green;
	uint8_t red;
#else
	uint8_t red;
	uint8_t green;
	uint8_t blue;
#endif
} srk_bgr_t;

typedef struct {
#ifdef __LITTLE_ENDIAN__
	uint8_t blue;
	uint8_t green;
	uint8_t red;
	uint8_t alpha;
#else
	uint8_t alpha;
	uint8_t red;
	uint8_t green;
	uint8_t blue;
#endif
} srk_bgra_t;

/// The format of the bitmap data
typedef enum {
	SRKImageFormatRGB,
	SRKImageFormatRGBA,
	SRKImageFormatBGR,
	SRKImageFormatBGRA,
	SRKImageFormatGrayscale
} SRKImageFormat;

/**
 * An NSImage subclass with bitmap related additions, such as
 * easy initializing with raw bitmap data, and writing of such data.
 */
@interface SRKImage : NSImage <SRKFile>

/// The raw bitmap format of the rawData
@property (readonly) SRKImageFormat format;

/// The raw data of the bitmap. Do not use: use -rawDataWithFormat: instead.
@property (readonly) NSData *rawData;

/// The size of the actual image. The data size should be width*height*formatSize.
@property (readonly) NSSize rawSize;

/**
 * Initialize with raw bitmap data.
 *
 * The data length must be size.width * size.height * sizeof(format)
 *
 * @param data The raw bitmap data
 * @param size The size of the resulting image
 * @param format The format of the pixels
 * @return self
 */
- (instancetype)initWithRawBitmapData:(NSData *)data
								 size:(NSSize)size
							   format:(SRKImageFormat)format;

/**
 * Initialize an SRKImage given an NSImage.
 *
 * This extracts raw data from the NSImage and stores it
 *
 * @param image An NSImage
 * @return self
 */
- (instancetype)initWithImage:(NSImage *)image;

/**
 * Get the raw data form of the bitmap image in requested format.
 *
 * @param format Format to get the data into
 * @return NSData on success, or nil on failure
 */
- (NSData *)rawDataWithFormat:(SRKImageFormat)format;

@end
