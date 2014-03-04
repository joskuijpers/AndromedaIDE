//
//  SRKWindowStyle.m
//  Sphere
//
//  Created by Jos Kuijpers on 24/02/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SRKWindowStyle.h"
#import "SRKFile_Private.h"
#import "SRKImage.h"

typedef struct {
	uint8_t signature[4];
	uint16_t version;
	uint8_t edge_width;
	uint8_t background_mode;
	srk_rgba_t corner_colors[4];
	uint8_t edge_offsets[4];
	uint8_t reserved[36];
} __attribute__((packed)) srk_rws_header_t;
_Static_assert(sizeof(srk_rws_header_t) == 64,"wrong struct size");

typedef struct {
	uint16_t width;
	uint16_t height;
} __attribute__((packed)) srk_rws_bitmap_header_t;
_Static_assert(sizeof(srk_rws_bitmap_header_t) == 4,"wrong struct size");

@implementation SRKWindowStyle {
	uint8_t _edgeOffsets[4];
	srk_rgba_t _cornerColors[4];
	NSMutableArray *_images;
}

- (instancetype)init
{
	self = [super init];
	if(self) {
		_backgroundMode = SRKWindowStyleModeTiled;
		_cornerColors[0] = (srk_rgba_t){0,0,0,255};
		_cornerColors[1] = (srk_rgba_t){0,0,0,255};
		_cornerColors[2] = (srk_rgba_t){0,0,0,255};
		_cornerColors[3] = (srk_rgba_t){0,0,0,255};
		_edgeOffsets[0] = 0;
		_edgeOffsets[1] = 0;
		_edgeOffsets[2] = 0;
		_edgeOffsets[3] = 0;

		_images = [NSMutableArray arrayWithCapacity:9];
		for(int i = 0; i < 9; i++) {
			NSImage *image;
			image = [[NSImage alloc] initWithSize:NSMakeSize(16, 16)];
			_images[i] = [[SRKImage alloc] initWithImage:image];
		}
	}
	return self;
}

- (instancetype)initWithPath:(NSString *)path
{
	self = [super initWithPath:path];
	if(self) {
		@try {
			if(![self loadFileAtPath:self.path])
				return nil;
		} @catch (NSException *ex) {
			return nil;
		}
	}
	return self;
}

- (BOOL)loadFileAtPath:(NSString *)path
{
	NSData *fileContents;
	NSError *error = NULL;
	size_t filePos = 0;
	srk_rws_header_t *header;

	// Load the data
	fileContents = [NSData dataWithContentsOfFile:path
										  options:NSDataReadingMappedIfSafe
											error:&error];
	if(error) {
		NSLog(@"Failed to load RWS file at %@: %@",path,error);
		return NO;
	}

	// Read the header
	if((header = srk_file_read_struct(fileContents,
											  sizeof(srk_rws_header_t),
											  &filePos)) == NULL) {
		NSLog(@"Failed to load RWS file at %@: file is invalid (0x1)",path);
		return NO;
	}

	// Do a bunch of checks
	if(memcmp(header->signature, ".rws", 4) != 0) {
		NSLog(@"Failed to load RWS file at %@: file is invalid (0x2)",path);
		return NO;
	}

	if(header->version < 1 || header->version > 2) {
		NSLog(@"Failed to load RWS file at %@: file is invalid (0x3)",path);
		return NO;
	}

	_backgroundMode = header->background_mode;
	memcpy(_edgeOffsets, header->edge_offsets, 4);
	memcpy(_cornerColors, header->corner_colors, 4 * sizeof(srk_rgba_t));

	_images = [NSMutableArray arrayWithCapacity:9];
	for(int i = 0; i < 9; i++) {
		SRKImage *img;

		if(header->version == 1)
			img = [self readBitmapFromData:fileContents
								atPosition:&filePos
							 withEdgeWidth:header->edge_width];
		else if(header->version == 2)
			img = [self readBitmapFromData:fileContents atPosition:&filePos];

		if(img == nil) {
			NSLog(@"Failed to load RWS file at %@: file is invalid (0x4){%d}",path,i);
			return NO;
		}

		_images[i] = img;
	}

	return YES;
}

- (SRKImage *)readBitmapFromData:(NSData *)data atPosition:(size_t *)filePos
{
	srk_rws_bitmap_header_t *header;
	NSData *imgData;
	SRKImage *image;

	if((header = srk_file_read_struct(data,
											  sizeof(srk_rws_bitmap_header_t),
											  filePos)) == NULL)
		return nil;

	if(header->width > 4096 || header->height > 4096)
		return nil;

	int size = header->width * header->height * sizeof(srk_rgba_t);
	imgData = [data subdataWithRange:NSMakeRange(*filePos, size)];
	*filePos += size;

	image = [[SRKImage alloc] initWithRawBitmapData:imgData
											   size:NSMakeSize(header->width, header->height)
											 format:SRKImageFormatRGBA];

	return image;
}

- (SRKImage *)readBitmapFromData:(NSData *)data
					  atPosition:(size_t *)filePos
				   withEdgeWidth:(uint8_t)edgeWidth
{
	NSData *imgData;
	SRKImage *image;

	int size = edgeWidth * edgeWidth * sizeof(srk_rgba_t);
	imgData = [data subdataWithRange:NSMakeRange(*filePos, size)];
	*filePos += size;

	image = [[SRKImage alloc] initWithRawBitmapData:imgData
											   size:NSMakeSize(edgeWidth, edgeWidth)
											 format:SRKImageFormatRGBA];

	return image;
}

- (BOOL)saveToFile:(NSString *)path
{
	NSMutableData *data;
	srk_rws_header_t header;
	NSError *error = NULL;

	data = [NSMutableData data];

	memset(&header, 0, sizeof(srk_rws_header_t));
	memcpy(header.signature, ".rws", 4);
	header.version = 2;
	header.background_mode = _backgroundMode;
	memcpy(header.corner_colors, _cornerColors, 4 * sizeof(srk_rgba_t));
	memcpy(header.edge_offsets, _edgeOffsets, 4);
	[data appendBytes:&header length:sizeof(srk_rws_header_t)];

	// Write the bitmaps
	for(SRKImage *image in _images) {
		srk_rws_bitmap_header_t bmp_header;

		bmp_header.width = image.rawSize.width;
		bmp_header.height = image.rawSize.height;
		[data appendBytes:&bmp_header length:sizeof(srk_rws_bitmap_header_t)];

		[data appendData:[image rawDataWithFormat:SRKImageFormatRGBA]];
	}

	// Write the file
	if(![data writeToFile:path
				  options:NSDataWritingAtomic
					error:&error]) {
		NSLog(@"Failed to save RWS file to %@: %@",path,error);
		return NO;
	}

	return YES;
}

- (void)setOffset:(uint8_t)offset forEdge:(SRKWindowStyleEdge)edge
{

}

- (uint8_t)getOffsetForEdge:(SRKWindowStyleEdge)edge
{
	if(edge <= 3)
		return _edgeOffsets[edge];
	return 0;
}

- (void)setBackgroundColor:(NSColor *)color forCorner:(SRKWindowStyleCorner)corner
{

}

- (NSColor *)getBackgroundColorForCorner:(SRKWindowStyleCorner)corner
{
	if(corner <= 3) {
		srk_rgba_t color = _cornerColors[corner];
		return [NSColor colorWithCalibratedRed:color.red/255.0
										 green:color.green/255.0
										  blue:color.blue/255.0
										 alpha:color.alpha/255.0];
	}
	return nil;
}

- (SRKImage *)getImage:(SRKWindowStyleImage)bitmap
{
	if(bitmap < 9)
		return _images[bitmap];
	return nil;
}

- (void)setImage:(SRKImage *)image atPosition:(SRKWindowStyleImage)bitmap
{

}

@end
