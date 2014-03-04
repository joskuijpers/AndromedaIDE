//
//  SRKTileSet.m
//  Sphere
//
//  Created by Jos Kuijpers on 04/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SRKTileSet_Private.h"
#import "SRKFile_Private.h"
#import "SRKImage.h"
#import "SRKObstructionMap.h"

typedef struct {
	uint8_t signature[4];
	uint16_t version;
	uint16_t num_tiles;
	uint16_t tile_width;
	uint16_t tile_height;
	uint16_t tile_bpp;
	uint8_t compression;
	uint8_t has_obstructions;
	uint8_t reserved[240];
} __attribute__((packed)) srk_rts_header_t;
_Static_assert(sizeof(srk_rts_header_t) == 256,"wrong struct size");

typedef struct {
	uint8_t obsolete1;
	uint8_t animated;
	uint16_t next_tile;
	uint16_t delay;
	uint8_t obsolete2;
	uint8_t block_type;
	uint16_t num_segments;
	uint16_t name_length;
	uint8_t terraformed;
	uint8_t reserved[19];
} __attribute__((packed)) srk_rts_info_block_t;
_Static_assert(sizeof(srk_rts_info_block_t) == 32,"wrong struct size");

typedef struct
{
	uint16_t x1;
	uint16_t y1;
	uint16_t x2;
	uint16_t y2;
} __attribute__((packed)) srk_rts_obstruction_segment_t;
_Static_assert(sizeof(srk_rts_obstruction_segment_t) == 8,"wrong struct size");

@implementation SRKTileSet {
	NSMutableArray *_tiles;
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

	// Load the data
	fileContents = [NSData dataWithContentsOfFile:path
										  options:NSDataReadingMappedIfSafe
											error:&error];
	if(error) {
		NSLog(@"Failed to load RTS file at %@: %@",path,error);
		return NO;
	}

	if(![self loadFromFile:fileContents
				atPosition:&filePos
					  path:path])
		return NO;

	return YES;
}

- (BOOL)loadFromFile:(NSData *)fileContents
		  atPosition:(size_t *)filePos
				path:(NSString *)path
{
	srk_rts_header_t *header;

	// Read the header
	if((header = srk_file_read_struct(fileContents,
									  sizeof(srk_rts_header_t),
									  filePos)) == NULL) {
		NSLog(@"Failed to load RTS at %@: file is invalid (0x1)",path);
		return NO;
	}

	// Do a bunch of checks
	if(memcmp(header->signature, ".rts", 4) != 0) {
		NSLog(@"Failed to load RTS file at %@: file is invalid (0x2)",path);
		return NO;
	}

	if(header->version != 1) {
		NSLog(@"Failed to load RTS file at %@: file is invalid (0x3)",path);
		return NO;
	}

	if(header->tile_bpp != 32) {
		NSLog(@"Failed to load RTS file at %@: file is invalid (0x4)",path);
		return NO;
	}

	if(header->num_tiles == 0) {
		NSLog(@"Failed to load RTS file at %@: file is invalid (0x5)",path);
		return NO;
	}

	if(header->tile_width > 4096 || header->tile_height > 4096) {
		NSLog(@"Failed to load RTS file at %@: file is invalid (0x6)",path);
		return NO;
	}

	_tileSize = NSMakeSize(header->tile_width,header->tile_height);

	// Load the tile image data
	_tiles = [NSMutableArray arrayWithCapacity:header->num_tiles];
	int tile_size = header->tile_width * header->tile_height * sizeof(srk_rgba_t);
	for(int i = 0; i < header->num_tiles; i++) {
		SRKTile *tile;
		NSData *imgData;

		tile = [[SRKTile alloc] init];

		imgData = [fileContents subdataWithRange:NSMakeRange(*filePos, tile_size)];
		*filePos += tile_size;
		tile.image = [[SRKImage alloc] initWithRawBitmapData:imgData
														size:_tileSize
													  format:SRKImageFormatRGBA];

		[_tiles addObject:tile];
	}

	// Load the tile info blocks
	for(int i = 0; i < header->num_tiles; i++) {
		srk_rts_info_block_t *info;
		SRKTile *tile;
		NSData *nameData;

		if((info = srk_file_read_struct(fileContents,
										sizeof(srk_rts_info_block_t),
										filePos)) == NULL) {
			NSLog(@"Failed to load RTS at %@: file is invalid (0x7){%d}",path,i);
			return NO;
		}

		tile = _tiles[i];

		tile.animated = info->animated;
		tile.nextTile = info->next_tile;
		tile.terraformable = info->terraformed;
		tile.delay = info->delay;

		nameData = [fileContents subdataWithRange:NSMakeRange(*filePos, info->name_length)];
		*filePos += info->name_length;
		tile.name = [[NSString alloc] initWithData:nameData encoding:NSUTF8StringEncoding];

		if(header->has_obstructions) {

			// Skip old existing obstruction data
			if(info->block_type == 1)
				*filePos += header->tile_width * header->tile_height;
			else if(info->block_type == 2) {
				tile.obstructionMap = [[SRKObstructionMap alloc] init];

				for(int j = 0; j < info->num_segments; j++) {
					srk_rts_obstruction_segment_t *segment;

					if((segment = srk_file_read_struct(fileContents,
													   sizeof(srk_rts_obstruction_segment_t),
													   filePos)) == NULL) {
						NSLog(@"Failed to load RTS at %@: file is invalid (0x8){%d}",path,i);
						return NO;
					}

					// TODO: make this a procedure with checks
					[tile.obstructionMap addSegment:NSMakeRect(segment->x1,
															   segment->y1,
															   segment->x2 - segment->x1,
															   segment->y2 - segment->y1)];
				}
			} else {
				NSLog(@"Failed to load RTS at %@: file is invalid (0x9){%d}",path,i);
				return NO;
			}
		}
	}

	return YES;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<SRKTileSet>{tileSize: %@, tiles: %@}",
			NSStringFromSize(_tileSize),_tiles];
}

@end

@implementation SRKTile

- (NSString *)description
{
	return [NSString stringWithFormat:@"<SRKTile>{name: %@, animated: %d, terraformable: %d, "
			@"nextTile: %d, delay: %d, image: %@, obstructionMap: %@}",
			_name,_animated,_terraformable,_nextTile,_delay,_image,_obstructionMap];
}

@end
