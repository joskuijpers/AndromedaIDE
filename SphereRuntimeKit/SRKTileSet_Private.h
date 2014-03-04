//
//  SRKTileSet_Private.h
//  Sphere
//
//  Created by Jos Kuijpers on 04/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SRKTileSet.h"

@interface SRKTileSet ()

- (BOOL)loadFromFile:(NSData *)fileContents
		  atPosition:(size_t *)filePos
				path:(NSString *)path;

@end
