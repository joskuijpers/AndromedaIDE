//
//  SRKFileRSS.m
//  Sphere
//
//  Created by Jos Kuijpers on 24/02/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SRKSpriteSet.h"
#include <stdint.h>

#import "SRKFile_Private.h"
#include "SRKImage.h"

#define MINMAX(v,min,max) (((v) < (min))?(min):(((v) > (max))?(max):(v)))

#pragma mark - File structures
typedef struct {
	uint8_t signature[4];
	uint16_t version;
	uint16_t num_images;
	uint16_t frame_width;
	uint16_t frame_height;
	uint16_t num_directions;
	uint16_t base_x1;
	uint16_t base_y1;
	uint16_t base_x2;
	uint16_t base_y2;
	uint8_t reserved[106];
} __attribute__((packed)) srk_rss_header_t;
_Static_assert(sizeof(srk_rss_header_t) == 128,"wrong struct size");

typedef struct {
	uint16_t num_frames;
	uint8_t reserved[62];
} __attribute__((packed)) srk_rss_direction_header_v2_t;
_Static_assert(sizeof(srk_rss_direction_header_v2_t) == 64,"wrong struct size");

typedef struct {
	uint16_t num_frames;
	uint8_t reserved[6];
	uint16_t name_length;
} __attribute__((packed)) srk_rss_direction_header_v3_t;
_Static_assert(sizeof(srk_rss_direction_header_v3_t) == 10,"wrong struct size");

typedef struct {
	uint16_t width;
	uint16_t height;
	uint16_t delay;
	uint8_t reserved[26];
} __attribute__((packed)) srk_rss_frame_header_v2_t;
_Static_assert(sizeof(srk_rss_frame_header_v2_t) == 32,"wrong struct size");

typedef struct {
	uint16_t index;
	uint16_t delay;
	uint8_t reserved[4];
} __attribute__((packed)) srk_rss_frame_v3_t;
_Static_assert(sizeof(srk_rss_frame_v3_t) == 8,"wrong struct size");

#pragma mark - Implementation of file loading and saving

@implementation SRKSpriteSet

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
	srk_rss_header_t *header;

	// Load the data
	fileContents = [NSData dataWithContentsOfFile:path
										  options:NSDataReadingMappedIfSafe
											error:&error];
	if(error) {
		NSLog(@"Failed to load RSS file at %@: %@",path,error);
		return NO;
	}

	// Read the header
	if((header = srk_file_read_struct(fileContents,
											  sizeof(srk_rss_header_t),
											  &filePos)) == NULL) {
		NSLog(@"Failed to load RSS file at %@: file is invalid (0x1)",path);
		return NO;
	}

	// Do a bunch of checks
	if(memcmp(header->signature, ".rss", 4) != 0) {
		NSLog(@"Failed to load RSS file at %@: file is invalid (0x2)",path);
		return NO;
	}

	if(header->version < 1 || header->version > 3) {
		NSLog(@"Failed to load RSS file at %@: file is invalid (0x3)",path);
		return NO;
	}

	if(header->frame_width <= 0 || header->frame_width > 4096
	   || header->frame_height <= 0 || header->frame_height > 4096) {
		NSLog(@"Failed to load RSS file at %@: file is invalid (0x4)",path);
		return NO;
	}

	_frameSize = NSMakeSize(header->frame_width, header->frame_height);

	uint16_t x1,x2,y1,y2;
	x1 = MINMAX(header->base_x1,0,header->frame_width - 1);
	x2 = MINMAX(header->base_x2,0,header->frame_width - 1);
	y1 = MINMAX(header->base_y1,0,header->frame_height - 1);
	y2 = MINMAX(header->base_y2,0,header->frame_height - 1);
	_base = NSMakeRect(x1,y1,x2 - x1,y2 - y1);

	// Direction names for version 1 and 2
	static NSString *directionNames[] = {
		@"north", @"northeast", @"east", @"southeast",
		@"south", @"southwest", @"west", @"northwest"
	};

	if(header->version == 1) {
		NSMutableArray *images; // SRKImage
		NSMutableArray *directions; // SRKSpriteSetDirection

		images = [NSMutableArray arrayWithCapacity:64];
		directions = [NSMutableArray arrayWithCapacity:8];

		// Each direction
		for(int i = 0; i < 8; i++) {
			SRKSpriteSetDirection *dir;
			NSMutableArray *frames;

			dir = [[SRKSpriteSetDirection alloc] init];
			dir.name = directionNames[i];

			frames = [NSMutableArray arrayWithCapacity:8];

			// Each frame
			for(int f = 0; f < 9; f++) {
				SRKSpriteSetFrame *frame;
				NSData *imgData;

				frame = [[SRKSpriteSetFrame alloc] init];
				frame.index = i*8+f;
				frame.animationDelay = SRK_RSS_DEFAULT_FRAME_DELAY;

				// Read the image
				int size = header->frame_width * header->frame_height * sizeof(srk_rgba_t);
				imgData = [fileContents subdataWithRange:NSMakeRange(filePos, size)];
				filePos += size;

				images[i * 8 + f] = [[SRKImage alloc] initWithRawBitmapData:imgData
																	   size:_frameSize
																	 format:SRKImageFormatRGBA];

				frames[f] = frame;
			}

			dir.frames = frames;
		}

		_images = images;
		_directions = directions;

	} else if(header->version == 2) {
		NSMutableArray *images, *directions;

		images = [NSMutableArray array];
		directions = [NSMutableArray arrayWithCapacity:header->num_directions];

		// For each direction
		for(int i = 0; i < header->num_directions; i++) {
			srk_rss_direction_header_v2_t *dir_header;
			SRKSpriteSetDirection *dir;
			NSMutableArray *frames;

			if((dir_header = srk_file_read_struct(fileContents,
													  sizeof(srk_rss_direction_header_v2_t),
													  &filePos)) == NULL) {
				NSLog(@"Failed to load RSS file at %@: file is invalid (0x5)",path);
				return NO;
			}

			dir = [[SRKSpriteSetDirection alloc] init];

			if(i < 8)
				dir.name = directionNames[i];
			else
				dir.name = [NSString stringWithFormat:@"extra %d",i];

			// Read the frames
			frames = [NSMutableArray arrayWithCapacity:dir_header->num_frames];
			for(int f = 0; f < dir_header->num_frames; f++) {
				srk_rss_frame_header_v2_t *frame_header;
				SRKSpriteSetFrame *frame;
				NSData *imgData;

				if((frame_header = srk_file_read_struct(fileContents,
														  sizeof(srk_rss_frame_header_v2_t),
														  &filePos)) == NULL) {
					NSLog(@"Failed to load RSS file at %@: file is invalid (0x6)",path);
					return NO;
				}

				frame = [[SRKSpriteSetFrame alloc] init];

				// Backwards compat. hack
				if(_frameSize.width == 0 || _frameSize.height == 0)
					_frameSize = NSMakeSize(frame_header->width, frame_header->height);

				// Get the image data
				int size = _frameSize.width * _frameSize.height * sizeof(srk_rgba_t);
				imgData = [fileContents subdataWithRange:NSMakeRange(filePos, size)];
				filePos += size;

				// Find the image in the existing image list, or add it to the list
				frame.index = -1;
				[images enumerateObjectsUsingBlock:^(SRKImage *img, NSUInteger idx, BOOL *stop) {
					if(img.size.width == frame_header->width
					   && img.size.height == frame_header->height
					   && img.rawData.length == imgData.length
					   && memcmp(img.rawData.bytes, imgData.bytes, img.rawData.length) == 0) {
						// Found a match
						frame.index = idx;
						*stop = YES;
					}
				}];

				// No image found yet: add one
				if(frame.index == -1) {
					SRKImage *image;

					image = [[SRKImage alloc] initWithRawBitmapData:imgData
															   size:_frameSize
															 format:SRKImageFormatRGBA];

					[images addObject:image];
					frame.index = images.count - 1;
				}

				frame.animationDelay = frame_header->delay;

				frames[f] = frame;
			}

			dir.frames = frames;
		}

		_directions = directions;
		_images = images;

	} else if(header->version == 3) {
		NSMutableArray *images; // NSImage
		NSMutableArray *directions; // SRKSpriteSetDirection

		// Read the images
		images = [NSMutableArray arrayWithCapacity:header->num_images];
		for(int i = 0; i < header->num_images; i++) {
			SRKImage *img;
			int size;
			NSData *imgData;

			size = header->frame_width * header->frame_height * sizeof(srk_rgba_t);
			imgData = [fileContents subdataWithRange:NSMakeRange(filePos, size)];
			filePos += size;

			img = [[SRKImage alloc] initWithRawBitmapData:imgData
													 size:NSMakeSize(header->frame_width,
																	 header->frame_height)
												   format:SRKImageFormatRGBA];
			images[i] = img;
		}
		_images = images;

		// Read the directions
		directions = [NSMutableArray arrayWithCapacity:header->num_directions];
		for(int i = 0; i < header->num_directions; i++) {
			SRKSpriteSetDirection *dir;
			srk_rss_direction_header_v3_t *dir_header;
			const char *cname;
			char *cname_buf;
			NSMutableArray *frames; // SRKSpriteSetFrame

			dir = [[SRKSpriteSetDirection alloc] init];

			// Read the header
			if((dir_header = srk_file_read_struct(fileContents,
													  sizeof(srk_rss_direction_header_v3_t),
													  &filePos)) == NULL) {
				NSLog(@"Failed to load RSS file at %@: file is invalid (0x7)",path);
				return NO;
			}

			// Read the name
			if(dir_header->name_length <= 0) {
				NSLog(@"Failed to load RSS file at %@: file is invalid (0x8){%d}",path,i);
				return NO;
			}

			if((cname = srk_file_read_struct(fileContents,
													  dir_header->name_length,
													  &filePos)) == NULL) {
				NSLog(@"Failed to load RSS file at %@: file is invalid (0x9)",path);
				return NO;
			}

			// Use a buffer to add a secure c string ending (\0)
			cname_buf = malloc(dir_header->name_length+1);
			memcpy(cname_buf, cname, dir_header->name_length);
			cname_buf[dir_header->name_length] = '\0';
			dir.name = [NSString stringWithUTF8String:cname_buf];
			free(cname_buf);

			// Read the frames for the direction
			frames = [NSMutableArray arrayWithCapacity:dir_header->num_frames];
			for(int j = 0; j < dir_header->num_frames; j++) {
				srk_rss_frame_v3_t *cframe;
				SRKSpriteSetFrame *frame;

				if((cframe = srk_file_read_struct(fileContents,
														  sizeof(srk_rss_frame_v3_t),
														  &filePos)) == NULL) {
					NSLog(@"Failed to load RSS file at %@: file is invalid (0xA)",path);
					return NO;
				}

				frame = [[SRKSpriteSetFrame alloc] init];
				frame.index = cframe->index;
				frame.animationDelay = cframe->delay;

				frames[j] = frame;
			}

			dir.frames = frames;
			directions[i] = dir;
		}
		_directions = directions;
	}

	return YES;
}

- (BOOL)saveToFile:(NSString *)path
{
	NSMutableData *fileContents;
	srk_rss_header_t file_header;
	NSError *error = NULL;

	fileContents = [NSMutableData data];

	// Fill and write the header
	memset(&file_header,0,sizeof(srk_rss_header_t));
	memcpy(file_header.signature, ".rss", 4);
	file_header.version = 3;
	file_header.num_images = _images.count;
	file_header.frame_width = _frameSize.width;
	file_header.frame_height = _frameSize.height;
	file_header.num_directions = _directions.count;
	file_header.base_x1 = _base.origin.x;
	file_header.base_y1 = _base.origin.y;
	file_header.base_x2 = _base.origin.x + _base.size.width;
	file_header.base_y2 = _base.origin.y + _base.size.height;

	[fileContents appendBytes:&file_header length:sizeof(srk_rss_header_t)];

	// Write images
	for(SRKImage *image in _images) {
		NSData *imgData;

		imgData = [image rawDataWithFormat:SRKImageFormatRGBA];
		if(!imgData) {
			NSLog(@"Failed to save RSS file to %@: Could not retrieve raw image data",path);
			return NO;
		}

		// Append the data
		[fileContents appendData:imgData];
	}

	// Write directions
	for(SRKSpriteSetDirection *direction in _directions)
	{
		srk_rss_direction_header_v3_t dir_header;

		// Write header
		dir_header.num_frames = direction.frames.count;
		dir_header.name_length = direction.name.length + 1;

		[fileContents appendBytes:&dir_header length:sizeof(srk_rss_direction_header_v3_t)];

		// Add the name
		[fileContents appendData:[direction.name dataUsingEncoding:NSUTF8StringEncoding]];

		// Write frames
		for(SRKSpriteSetFrame *frame in direction.frames) {
			srk_rss_frame_v3_t cframe;

			cframe.index = frame.index;
			cframe.delay = frame.animationDelay;

			[fileContents appendBytes:&cframe length:sizeof(srk_rss_frame_v3_t)];
		}
	}

	// Write out to the file
	if(![fileContents writeToFile:path
					  options:NSDataWritingAtomic
						error:&error]) {
		NSLog(@"Failed to save RSS file to %@: %@",path,error);
		return NO;
	}

	return YES;
}

@end

@implementation SRKSpriteSetDirection
@end

@implementation SRKSpriteSetFrame
@end