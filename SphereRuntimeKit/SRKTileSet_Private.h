//
//  SRKTileSet_Private.h
//  Sphere
//
//  Created by Jos Kuijpers on 04/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SRKTileSet.h"

@interface SRKTileSet ()

/**
 * Loads the tile set from an existing opened file
 *
 * @param fileContents Contents of the file
 * @param filePos Reference to the seek position in the file
 * @param path Path to be used in error messages
 * @return YES on success, NO on failure
 */
- (BOOL)loadFromFile:(NSData *)fileContents
		  atPosition:(size_t *)filePos
				path:(NSString *)path;

@end
