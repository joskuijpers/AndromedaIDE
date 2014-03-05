//
//  SRKFileRMP.m
//  Sphere
//
//  Created by Jos Kuijpers on 24/02/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SRKMap.h"
#import "SRKFile_Private.h"
#import "SRKTileSet_Private.h"
#import "SRKObstructionMap.h"
#import "SRKImage.h"
#import "SRKSpriteSet.h"

typedef struct {
	uint8_t signature[4];
	uint16_t version;
	uint8_t reserved0;
	uint8_t num_layers;
	uint8_t reserved1;
	uint16_t num_entities;
	uint16_t start_x;
	uint16_t start_y;
	uint8_t start_layer;
	uint8_t start_direction;
	uint16_t num_strings;
	uint16_t num_zones;
	uint8_t repeating;
	uint8_t reserved2[234];
} __attribute__((packed)) srk_rmp_header_t ;
_Static_assert(sizeof(srk_rmp_header_t) == 256,"wrong struct size");

typedef struct {
	uint16_t width;
	uint16_t height;
	uint16_t flags;
	float parallax_x;
	float parallax_y;
	float scrolling_x;
	float scrolling_y;
	uint32_t num_segments;
	uint8_t reflective;
	uint8_t reserved[3];
} __attribute__((packed)) srk_rmp_layer_header_t;
_Static_assert(sizeof(srk_rmp_layer_header_t) == 30,"wrong struct size");

#define SRK_RMP_LAYER_FLAG_INVISIBLE	0x0001
#define SRK_RMP_LAYER_FLAG_PARALLAX		0x0002

typedef struct
{
	uint32_t x1;
	uint32_t y1;
	uint32_t x2;
	uint32_t y2;
} __attribute__((packed)) srk_rmp_layer_obstruction_segment_t;
_Static_assert(sizeof(srk_rmp_layer_obstruction_segment_t) == 16,"wrong struct size");

typedef struct {
	uint16_t map_x;
	uint16_t map_y;
	uint16_t layer; // only 8 bits used (num_layers is 8bit)
	uint16_t type;
	uint8_t reserved[8];
} __attribute__((packed)) srk_rmp_entity_header_t;
_Static_assert(sizeof(srk_rmp_entity_header_t) == 16,"wrong struct size");

typedef struct {
	uint16_t x1;
	uint16_t y1;
	uint16_t x2;
	uint16_t y2;
	uint16_t layer; // only 8 bits used (num_layers is 8bit)
	uint16_t reactivate_in_num_steps;
	uint8_t reserved[4];
} __attribute__((packed)) srk_rmp_zone_header_t;
_Static_assert(sizeof(srk_rmp_zone_header_t) == 16,"wrong struct size");

@interface SRKMapLayer ()

@property (strong) NSMutableData *tileData;

@end

@implementation SRKMap {
	NSMutableArray *_edgeScripts;
	NSMutableArray *_layers;
	NSMutableArray *_entities;
	NSMutableArray *_zones;
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
	srk_rmp_header_t *header;

	// Load the data
	fileContents = [NSData dataWithContentsOfFile:path
										  options:NSDataReadingMappedIfSafe
											error:&error];
	if(error) {
		NSLog(@"Failed to load RMP file at %@: %@",path,error);
		return NO;
	}

	// Read the header
	if((header = srk_file_read_struct(fileContents,
											  sizeof(srk_rmp_header_t),
											  &filePos)) == NULL) {
		NSLog(@"Failed to load RMP file at %@: file is invalid (0x1)",path);
		return NO;
	}

	// Do a bunch of checks
	if(memcmp(header->signature, ".rmp", 4) != 0) {
		NSLog(@"Failed to load RMP file at %@: file is invalid (0x2)",path);
		return NO;
	}

	if(header->version != 1) {
		NSLog(@"Failed to load RMP file at %@: file is invalid (0x3)",path);
		return NO;
	}

	if(header->num_strings != 3 && header->num_strings != 5 && header->num_strings != 9) {
		NSLog(@"Failed to load RMP file at %@: file is invalid (0x4)",path);
		return NO;
	}

	_startLocation = NSMakePoint(header->start_x, header->start_y);
	_startDirection = header->start_direction;
	_startLayer = header->start_layer;
	_repeating = (header->repeating != 0);

	NSString *tileSetName;
	tileSetName = srk_file_read_string(fileContents, &filePos); // string 1, tile set file
	_musicFilename = srk_file_read_string(fileContents, &filePos); // string 2, music file
	srk_file_read_string(fileContents, &filePos); // string 3, script file, obsolete

	if(header->num_strings < 4) {
		_entryScript = @"";
		_exitScript = @"";
	} else {
		_entryScript = srk_file_read_string(fileContents, &filePos); // string 4
		_exitScript = srk_file_read_string(fileContents, &filePos); // string 5
	}

	// Read edge scripts
	if(header->num_strings > 5) {
		NSArray *scripts;
		scripts = @[srk_file_read_string(fileContents, &filePos), // string 6
					srk_file_read_string(fileContents, &filePos), // string 7
					srk_file_read_string(fileContents, &filePos), // string 8
					srk_file_read_string(fileContents, &filePos) // string 9
					];

		_edgeScripts = [NSMutableArray arrayWithArray:scripts];
	}

	// Read all layers
	_layers = [NSMutableArray array];
	for(int i = 0; i < header->num_layers; i++) {
		srk_rmp_layer_header_t *layer_header;
		SRKMapLayer *layer;
		NSData *layerData;

		// Read the header
		if((layer_header = srk_file_read_struct(fileContents,
												sizeof(srk_rmp_layer_header_t),
												&filePos)) == NULL) {
			NSLog(@"Failed to load RMP file at %@: file is invalid (0x5){%d}",path,i);
			return NO;
		}

		// Fill the layer info
		layer = [[SRKMapLayer alloc] init];
		layer.size = NSMakeSize(layer_header->width, layer_header->height);
		layer.parallax = NSMakePoint(layer_header->parallax_x, layer_header->parallax_y);
		layer.scrolling = NSMakePoint(layer_header->scrolling_x, layer_header->scrolling_y);
		layer.visible = (layer_header->flags & SRK_RMP_LAYER_FLAG_INVISIBLE) == 0;
		layer.hasParallax = layer_header->flags & SRK_RMP_LAYER_FLAG_PARALLAX;
		layer.reflective = layer_header->reflective != 0;
		layer.name = srk_file_read_string(fileContents, &filePos);

		// Get the layer data
		int size = layer_header->width * layer_header->height * sizeof(uint16_t);
		layerData = [fileContents subdataWithRange:NSMakeRange(filePos, size)];
		filePos += size;
		layer.tileData = [layerData mutableCopy];

		// Load obstruction map
		for(int j = 0; j < layer_header->num_segments; j++) {
			srk_rmp_layer_obstruction_segment_t *segment;

			if((segment = srk_file_read_struct(fileContents,
											   sizeof(srk_rmp_layer_obstruction_segment_t),
											   &filePos)) == NULL) {
				NSLog(@"Failed to load RMP file at %@: file is invalid (0x6){%d,%d}",path,i,j);
				return NO;
			}

			[layer.obstructionMap addSegment:NSMakeRect(segment->x1,
														segment->y1,
														segment->x2 - segment->x1,
														segment->y2 - segment->y1)];
		}

		[_layers addObject:layer];
	}

	// Read all entities
	_entities = [NSMutableArray arrayWithCapacity:header->num_entities];
	for(int i = 0; i < header->num_entities; i++) {
		srk_rmp_entity_header_t *entity_header;
		SRKMapEntity *entity;

		// Read the header
		if((entity_header = srk_file_read_struct(fileContents,
												sizeof(srk_rmp_entity_header_t),
												&filePos)) == NULL) {
			NSLog(@"Failed to load RMP file at %@: file is invalid (0x6){%d}",path,i);
			return NO;
		}

		switch(entity_header->type) {
			case 1: { // person
				SRKMapPerson *person;
				uint16_t num_strings;

				person = [[SRKMapPerson alloc] init];

				person.name = srk_file_read_string(fileContents, &filePos);
				person.spriteSetFilename = srk_file_read_string(fileContents, &filePos);

				if(!srk_file_read_word(fileContents, &filePos, &num_strings)) {
					NSLog(@"Failed to load RMP file at %@: file is invalid (0x7){%d}",path,i);
					return 0;
				}

				if(num_strings >= 1)
					person.createScript = srk_file_read_string(fileContents, &filePos);
				if(num_strings >= 2)
					person.destroyScript = srk_file_read_string(fileContents, &filePos);
				if(num_strings >= 3)
					person.activateTouchScript = srk_file_read_string(fileContents, &filePos);
				if(num_strings >= 4)
					person.activateTalkScript = srk_file_read_string(fileContents, &filePos);
				if(num_strings >= 5)
					person.generateCommandsScript = srk_file_read_string(fileContents, &filePos);

				filePos += 16; // 16 reserved bytes

				entity = person;
			}
				break;
			case 2: { // trigger
				SRKMapTrigger *trigger;

				trigger = [[SRKMapTrigger alloc] init];
				trigger.script = srk_file_read_string(fileContents, &filePos);

				entity = trigger;
			}
				break;
			default:
				NSLog(@"Failed to load RMP file at %@: file is invalid (0x8){%d}",path,i);
				return NO;
		}

		entity.location = NSMakePoint(entity_header->map_x, entity_header->map_y);
		entity.layer = (entity_header->layer > header->num_layers)?0:entity_header->layer;

		[_entities addObject:entity];
	}

	// Read all zones
	_zones = [NSMutableArray arrayWithCapacity:header->num_zones];
	for(int i = 0; i < header->num_zones; i++) {
		srk_rmp_zone_header_t *zone_header;
		SRKMapZone *zone;

		// Read the header
		if((zone_header = srk_file_read_struct(fileContents,
											   sizeof(srk_rmp_zone_header_t),
											   &filePos)) == NULL) {
			NSLog(@"Failed to load RMP file at %@: file is invalid (0x9){%d}",path,i);
			return NO;
		}

		zone = [[SRKMapZone alloc] init];
		// TODO make code that creates NSRect from x1,x2,y1,y2 with correct swapping
		//		if (zh.x1 > zh.x2) {
		//			word temp = zh.x1;
		//			zh.x1 = zh.x2;
		//			zh.x2 = temp;
		//		}
		//		if (zh.y1 > zh.y2) {
		//			word temp = zh.y1;
		//			zh.y1 = zh.y2;
		//			zh.y2 = temp;
		//		}
		zone.area = NSMakeRect(zone_header->x1,
							   zone_header->y1,
							   zone_header->x2 - zone_header->x1,
							   zone_header->y2 - zone_header->y1);
		zone.layer = (zone_header->layer > header->num_layers)?0:zone_header->layer;
		zone.reactivation_steps = zone_header->reactivate_in_num_steps;
		zone.script = srk_file_read_string(fileContents, &filePos);

		[_zones addObject:zone];
	}

	// Read the tilemap, if no file specified
	if(tileSetName.length > 0) {
		NSLog(@"TileSet in image! %@",tileSetName);
	} else {
		_tileSet = [[SRKTileSet alloc] init];
		if(![_tileSet loadFromFile:fileContents
						atPosition:&filePos
							  path:path]) {
			NSLog(@"Failed to load RMP file at %@: file is invalid (0xA)",path);
			return NO;
		}
	}

	return YES;
}

- (BOOL)saveToFile:(NSString *)path
{
	NSMutableData *fileContents;
//	srk_rss_header_t file_header;
	NSError *error = NULL;

	fileContents = [NSMutableData data];

	// Fill and write the header
//	memset(&file_header,0,sizeof(srk_rss_header_t));

	// Write out to the file
	if(![fileContents writeToFile:path
						  options:NSDataWritingAtomic
							error:&error]) {
		NSLog(@"Failed to save RSS file to %@: %@",path,error);
		return NO;
	}
	
	return YES;
}

- (SRKImage *)initialMapImage
{
	SRKImage *image;
	NSSize mapSize, imageSize;

	mapSize = [(SRKMapLayer *)_layers[0] size];
	imageSize = NSMakeSize(mapSize.width * 32, mapSize.height * 32);

	// Assume tilesize = 32px * 32px
	image = [[SRKImage alloc] initWithSize:imageSize];
	[image lockFocus];

	for(int y = 0; y < mapSize.width; y++) {
		for(int x = 0; x < mapSize.height; x++) {
			for(int l = 0; l < _layers.count; l++) {
				SRKTile *tile;
				SRKMapLayer *layer;
				int tileIndex;

				layer = _layers[l];
				if(!layer.visible)
					continue;

				tileIndex = [layer tileIndexAtPoint:NSMakePoint(x, y)];
				if(tileIndex >= _tileSet.tiles.count)
					continue;
				tile = _tileSet.tiles[tileIndex];

				[tile.image drawAtPoint:NSMakePoint(x * 32, imageSize.height - y * 32)
							   fromRect:NSZeroRect
							  operation:NSCompositeSourceOver
							   fraction:1.0];
			}
		}
	}

	// Draw entities
	for(SRKMapEntity *entity in _entities) {
		if([entity isKindOfClass:[SRKMapTrigger class]])
			continue;
		SRKMapPerson *person = (SRKMapPerson *)entity;
		NSString *path = [self.path stringByDeletingLastPathComponent];
		path = [path stringByDeletingLastPathComponent];
		path = [path stringByAppendingPathComponent:@"spritesets"];
		path = [path stringByAppendingPathComponent:person.spriteSetFilename];
		SRKSpriteSet *rss = [[SRKSpriteSet alloc] initWithPath:path];

		SRKSpriteSetDirection *dir = rss.directions[0];
		SRKSpriteSetFrame *frame = dir.frames[0];
		if(rss.directions.count >= 3) {
			dir = rss.directions[1];
			if(dir.frames.count >= 2)
				frame = dir.frames[1];
		}

		[rss.images[frame.index] drawAtPoint:NSMakePoint(person.location.x - 16, imageSize.height - person.location.y + 16)
						  fromRect:NSZeroRect
						 operation:NSCompositeSourceOver
						  fraction:1.0];
	}


	[image unlockFocus];

	return image;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<SRKMap>{startLocation: %@, startLayer: %d, startDirection:"
			@" %d, repeating: %d, musicFilename: %@, entryScript: '%@', exitScript: '%@', "
			@"edgeScripts: %@, layers: %@, entities: %@, zones: %@, tileset: %@}",
			NSStringFromPoint(_startLocation), _startLayer, _startDirection,_repeating,
			_musicFilename,_entryScript,_exitScript, _edgeScripts,_layers,_entities,_zones,
			_tileSet];
}

@end

@implementation SRKMapLayer

@synthesize tileData=_tileData;

- (id)init
{
	self = [super init];
	if(self) {
		_obstructionMap = [[SRKObstructionMap alloc] init];
	}
	return self;
}

- (unsigned int)tileIndexAtPoint:(NSPoint)point
{
	uint16_t *words;

	words = (uint16_t *)[_tileData bytes];
	words += (int)point.y * (int)_size.width  + (int)point.x;

	return *words;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<SRKMapLayer>{size: %@, name: %@, hasParallax: %d, "
			@"parallax: %@, scrolling: %@, isVisible: %d, isReflective: %d, "
			@"obstructionMap: %@}",NSStringFromSize(_size),_name,_hasParallax,
			NSStringFromPoint(_parallax),NSStringFromPoint(_scrolling),_visible,_reflective,
			_obstructionMap];
}

@end

@implementation SRKMapZone

- (NSString *)description
{
	return [NSString stringWithFormat:@"<SRKMapZone>{area: %@, layer: %d, reactivation_steps: %d, "
			@"script: %@}",
			NSStringFromRect(_area),_layer,_reactivation_steps,_script];
}

@end

@implementation SRKMapEntity

- (NSString *)description
{
	return [NSString stringWithFormat:@"<SRKMapEntity>{location: %@, layer: %d}",
			NSStringFromPoint(_location),_layer];
}

@end

@implementation SRKMapPerson

- (NSString *)description
{
	return [NSString stringWithFormat:@"<SRKMapPerson>{super: %@, name: %@, spriteSet: %@, create: "
			@"%@, destroy: %@, touch: %@, talk: %@, generate: %@}",
			[super description],_name,_spriteSetFilename,_createScript,_destroyScript,
			_activateTouchScript,_activateTalkScript,_generateCommandsScript];
}

@end

@implementation SRKMapTrigger

- (NSString *)description
{
	return [NSString stringWithFormat:@"<SRKMapTrigger>{super: %@, script: %@}",
			[super description],_script];
}

@end

