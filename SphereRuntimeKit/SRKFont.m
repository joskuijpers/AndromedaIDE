//
//  SRKFont.m
//  Sphere
//
//  Created by Jos Kuijpers on 25/02/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SRKFont.h"
#import "SRKFile_Private.h"

#pragma mark - File structures
typedef struct {
	uint8_t signature[4];
	uint16_t version;
	uint16_t num_characters;
	uint8_t reserved[248];
} __attribute__((packed)) srk_rfn_header_t;
_Static_assert(sizeof(srk_rfn_header_t) == 256,"wrong struct size");

typedef struct {
	uint16_t width;
	uint16_t height;
	uint8_t reserved[28];
} __attribute__((packed)) srk_rfn_character_header_t;
_Static_assert(sizeof(srk_rfn_character_header_t) == 32,"wrong struct size");

@implementation SRKFont

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
	srk_rfn_header_t *header;
	NSMutableArray *characters;

	// Load the data
	fileContents = [NSData dataWithContentsOfFile:path
										  options:NSDataReadingMappedIfSafe
											error:&error];
	if(error) {
		NSLog(@"Failed to load RFN file at %@: %@",path,error);
		return NO;
	}

	// Read the header
	if((header = srk_file_read_struct(fileContents,
											  sizeof(srk_rfn_header_t),
											  &filePos)) == NULL) {
		NSLog(@"Failed to load RFN file at %@: file is invalid (0x1)",path);
		return NO;
	}

	// Do a bunch of checks
	if(memcmp(header->signature, ".rfn", 4) != 0) {
		NSLog(@"Failed to load RFN file at %@: file is invalid (0x2)",path);
		return NO;
	}

	if(header->version < 1 || header->version > 2) {
		NSLog(@"Failed to load RFN file at %@: file is invalid (0x3)",path);
		return NO;
	}

	if(header->num_characters == 0) {
		NSLog(@"Failed to load RFN file at %@: file is invalid (0x4)",path);
		return NO;
	}

	// Read all characters
	characters = [[NSMutableArray alloc] initWithCapacity:header->num_characters];
	for(int i = 0; i < header->num_characters; i++) {
		srk_rfn_character_header_t *char_header;
		SRKImage *image;

		if((char_header = srk_file_read_struct(fileContents,
												  sizeof(srk_rfn_character_header_t),
												  &filePos)) == NULL) {
			NSLog(@"Failed to load RFN file at %@: file is invalid (0x5)",path);
			return NO;
		}

		if(char_header->width > 4096 || char_header->height > 4096) {
			NSLog(@"Failed to load RFN file at %@: character %d is too big",path,i);
			return NO;
		}


		if(header->version == 1) { // grayscale
			NSData *imgData;

			int size = char_header->width * char_header->height;
			imgData = [fileContents subdataWithRange:NSMakeRange(filePos, size)];
			filePos += size;

			image = [[SRKImage alloc] initWithRawBitmapData:imgData
													   size:NSMakeSize(char_header->width, char_header->height)
													 format:SRKImageFormatGrayscale];
			if(image == nil) {
				NSLog(@"Failed to load RFN file at %@: failed to load glyph %d (0x6)",path,i);
				return NO;
			}
		} else if(header->version == 2) { // rgba
			NSData *imgData;

			int size = char_header->width * char_header->height * sizeof(srk_rgba_t);
			imgData = [fileContents subdataWithRange:NSMakeRange(filePos, size)];
			filePos += size;

			image = [[SRKImage alloc] initWithRawBitmapData:imgData
													   size:NSMakeSize(char_header->width, char_header->height)
													 format:SRKImageFormatRGBA];
			if(image == nil) {
				NSLog(@"Failed to load RFN file at %@: failed to load glyph %d (0x7)",path,i);
				return NO;
			}
		}

		characters[i] = image;
	}

	_characters = characters;

	return YES;
}

- (BOOL)saveToFile:(NSString *)path
{
	NSMutableData *data;
	srk_rfn_header_t header;
	NSError *error = NULL;

	data = [NSMutableData data];

	// Fill the header
	memset(&header, 0, sizeof(srk_rfn_header_t));
	memcpy(header.signature, ".rfn", 4);
	header.version = 2;
	header.num_characters = _characters.count;
	[data appendBytes:&header length:sizeof(srk_rfn_header_t)];

	// Write glyphs
	for(SRKImage *glyph in _characters) {
		srk_rfn_character_header_t char_header;

		memset(&char_header, 0, sizeof(srk_rfn_character_header_t));
		char_header.width = glyph.rawSize.width;
		char_header.height = glyph.rawSize.height;
		[data appendBytes:&header length:sizeof(srk_rfn_character_header_t)];

		[data appendData:[glyph rawDataWithFormat:SRKImageFormatRGBA]];
	}

	// Write the file
	if(![data writeToFile:path
			  options:NSDataWritingAtomic
				error:&error]) {
		NSLog(@"Failed to save RFN file to %@: %@",path,error);
		return NO;
	}

	return YES;
}

@end
