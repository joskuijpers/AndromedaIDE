//
//  SRKImage.m
//  Sphere
//
//  Created by Jos Kuijpers on 25/02/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

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
		@throw [NSException exceptionWithName:@"NotImplementedException"
									   reason:@"Not implemented"
									 userInfo:nil];
	}
	return self;
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
	   || CGImageGetHeight(imageRef) != size.height)
		return nil;

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

	fileType = NSJPEGFileType;
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
