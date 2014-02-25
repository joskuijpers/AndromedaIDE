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

typedef enum {
	SRKImageFormatRGB,
	SRKImageFormatRGBA,
	SRKImageFormatBGR,
	SRKImageFormatBGRA
} SRKImageFormat;

@interface SRKImage : NSImage <SRKFile>

@property (readonly,assign) SRKImageFormat format;
@property (readonly,strong) NSData *rawData;

- (instancetype)initWithRawBitmapData:(NSData *)data
								 size:(NSSize)size
							   format:(SRKImageFormat)format;
- (instancetype)initWithImage:(NSImage *)image;

- (NSData *)rawDataWithFormat:(SRKImageFormat)format;

@end
