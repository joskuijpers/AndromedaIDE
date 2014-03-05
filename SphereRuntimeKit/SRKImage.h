//
//  SRKImage.h
//  Sphere
//
//  Created by Jos Kuijpers on 25/02/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

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
@property (readonly,assign) SRKImageFormat format;

/// The raw data of the bitmap. Do not use: use -rawDataWithFormat: instead.
@property (readonly,strong) NSData *rawData;

/// The size of the actual image. The data size should be width*height*formatSize.
@property (readonly,assign) NSSize rawSize;

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
