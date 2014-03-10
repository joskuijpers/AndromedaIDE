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

#import "SRKImage.h"

@implementation SRKImage

@synthesize path=_path;

- (instancetype)initWithRawBitmapData:(NSData *)data
								 size:(NSSize)size
							   format:(SRKImageFormat)format
{
	CGImageRef imageRef;

	imageRef = cgimage_from_raw_bitmap(size, data, format);
	if(imageRef == NULL)
		return nil;

	self = [super initWithCGImage:imageRef size:size];
	CGImageRelease(imageRef);
	if(self) {
		_format = format;
		_rawData = data;
		_rawSize = size;
	}
	return self;
}

- (instancetype)initWithPath:(NSString *)path
{
	NSImage *image;

	// Load the image
	image = [[NSImage alloc] initWithContentsOfFile:path];

	self = [self initWithImage:image];
	if(self) {
		_path = [path copy];
	}
	return self;
}

- (instancetype)initWithImage:(NSImage *)image
{
	self = [super init];
	if(self) {
		_rawData = raw_data_from_nsimage(image,SRKImageFormatRGBA);
		_rawSize = image.size;
		_format = SRKImageFormatRGBA;
	}
	return self;
}

- (instancetype)initWithSize:(NSSize)aSize
{
	self = [super initWithSize:aSize];
	if(self) {
//		_rawData = raw_data_from_nsimage(self,SRKImageFormatRGBA);
		_rawSize = aSize;
		_format = SRKImageFormatRGBA;
	}
	return self;
}

NSData *raw_data_from_nsimage(NSImage *image, SRKImageFormat format) {
	NSData *imgData;
	NSBitmapImageRep *bmpRep;
	int size;

	bmpRep = [image representations][0];

	if(format == SRKImageFormatRGB && bmpRep.bitsPerPixel == 3*8) {
		size = sizeof(srk_rgb_t) * image.size.width * image.size.height;
		imgData = [NSData dataWithBytes:[bmpRep bitmapData] length:size];
	} else if(format == SRKImageFormatRGBA && bmpRep.bitsPerPixel == 4*8) {
		size = sizeof(srk_rgba_t) * image.size.width * image.size.height;
		imgData = [NSData dataWithBytes:[bmpRep bitmapData] length:size];
	} else { // Convert
		NSLog(@"TODO");
		return nil;
	}

	return imgData;
}

CGImageRef cgimage_from_raw_bitmap(NSSize size, NSData *data, SRKImageFormat format)
{
	CGDataProviderRef provider;
	CGColorSpaceRef colorSpaceRef;
	CGImageRef imageRef;
	CGBitmapInfo bitmapInfo;
	int numComponents;

	switch (format) {
		case SRKImageFormatRGB:
			numComponents = 3;
			bitmapInfo = kCGBitmapByteOrder32Big | kCGImageAlphaNone;
			break;
		case SRKImageFormatRGBA:
		case SRKImageFormatGrayscale:
			numComponents = 4;
			bitmapInfo = kCGBitmapByteOrder32Big | kCGImageAlphaLast;
			break;
		case SRKImageFormatBGR:
			numComponents = 3;
			bitmapInfo = kCGBitmapByteOrder32Little | kCGImageAlphaNone;
			break;
		case SRKImageFormatBGRA:
			numComponents = 4;
			bitmapInfo = kCGBitmapByteOrder32Little | kCGImageAlphaFirst;
			break;
		default:
			NSLog(@"Failed to create image from data: %d is an invalid format.",format);
			return NULL;
	}

	if(format == SRKImageFormatGrayscale) {
		// TODO STUFF
		NSMutableData *newBuf;
		int bufSize;
		uint8_t *oldBuf;
		srk_rgba_t *newBufPtr;

		bufSize = size.width * size.height * sizeof(srk_rgba_t);
		if(data.length != size.width * size.height) {
			NSLog(@"Failed to convert grayscale image: data size incorrect");
			return NULL;
		}

		newBuf = [NSMutableData dataWithLength:bufSize];
		oldBuf = (uint8_t *)[data bytes];
		newBufPtr = [newBuf mutableBytes];

		// For every pixel, add an rgba pixel
		for(int i = 0; i < size.width * size.height; i++) {
			newBufPtr->red = 0;
			newBufPtr->green = 0;
			newBufPtr->blue = 0;
			newBufPtr->alpha = oldBuf[i];
			newBufPtr++; // Next color
		}

		data = newBuf;
	}

	provider = CGDataProviderCreateWithCFData((CFDataRef)data);
	colorSpaceRef = CGColorSpaceCreateDeviceRGB();

	imageRef = CGImageCreate(size.width,
							 size.height,
							 8, // sizeof uint8_t * 8
							 8 * numComponents,
							 numComponents * size.width,
							 colorSpaceRef,
							 bitmapInfo,
							 provider,
							 NULL,
							 NO,
							 kCGRenderingIntentDefault);

	if(CGImageGetWidth(imageRef) != size.width
	   || CGImageGetHeight(imageRef) != size.height) {
		CGColorSpaceRelease(colorSpaceRef);
		CGDataProviderRelease(provider);
		CGImageRelease(imageRef);
		return nil;
	}

	CGColorSpaceRelease(colorSpaceRef);
	CGDataProviderRelease(provider);

	return imageRef;
}

NSImage *srk_nsimage_from_cgimage(CGImageRef imageRef, NSSize size)
{
	return [[NSImage alloc] initWithCGImage:imageRef size:size];
}

- (BOOL)save
{
	if(_path.length == 0)
		return NO;
	return [self saveToFile:_path];
}

- (BOOL)saveToFile:(NSString *)path
{
	NSData *data;
	NSBitmapImageRep *rep;
	NSBitmapImageFileType fileType;

	fileType = NSPNGFileType;
	if([[path pathExtension] isEqualToString:@"jpg"]
	   || [[path pathExtension] isEqualToString:@"jpeg"])
		fileType = NSJPEGFileType;
	else if([[path pathExtension] isEqualToString:@"gif"])
		fileType = NSGIFFileType;
	else if([[path pathExtension] isEqualToString:@"bmp"])
		fileType = NSBMPFileType;
	else if([[path pathExtension] isEqualToString:@"tiff"])
		fileType = NSTIFFFileType;

	[self lockFocus];
	rep = [[NSBitmapImageRep alloc] initWithFocusedViewRect:
		   NSMakeRect(0, 0, self.size.width, self.size.height)];
	[self unlockFocus];

	data = [rep representationUsingType:fileType
							 properties:nil];

	if([data writeToFile:path atomically:NO])
		return YES;
	return NO;
}

// For converting to raw buffer, and also for raw editing
//http://stackoverflow.com/questions/1994082/get-pixels-and-colours-from-nsimage

- (NSData *)rawDataWithFormat:(SRKImageFormat)format
{
	if(format == _format
	   && _rawData.length != 0)
		return _rawData;

	@throw [NSException exceptionWithName:@"NotImplementedException"
								   reason:@"Not implemented"
								 userInfo:nil];

	return nil;
}

@end
