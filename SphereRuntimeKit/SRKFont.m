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
} srk_rfn_header_t;
_Static_assert(sizeof(srk_rfn_header_t) == 256,"wrong struct size");

typedef struct {
	uint16_t width;
	uint16_t height;
	uint8_t reserved[28];
} srk_rfn_character_header_t;
_Static_assert(sizeof(srk_rfn_character_header_t) == 32,"wrong struct size");

@implementation SRKFont

- (instancetype)initWithPath:(NSString *)path
{
	self = [super initWithPath:path];
	if(self) {
		if(![self loadFileAtPath:self.path])
			return nil;
	}
	return self;
}

// TODO: with every increase of FilePos, need to check for end of file
// or better, before reading, check if the read (pointer assign) fits
// to prevent segfaults
- (BOOL)loadFileAtPath:(NSString *)path
{
	NSData *fileContents;
	NSError *error = NULL;
	const uint8_t *bytes;
	uint32_t filePos = 0;
	srk_rfn_header_t *header;

	return NO;
}

@end
