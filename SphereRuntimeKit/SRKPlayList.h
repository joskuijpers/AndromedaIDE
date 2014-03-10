//
//  SRKPlayList.h
//  Sphere
//
//  Created by Jos Kuijpers on 05/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import <SphereRuntimeKit/SphereRuntimeKit.h>

/**
 * A playlist, usable within the game
 */
@interface SRKPlayList : SRKFile

/**
 * An array of NSStrings each pointing to a sound
 * relative to /sounds/
 */
@property (readonly) NSArray *filenames;

/**
 * Adds given file to the playlist
 * 
 * @param path Path to the file
 */
- (void)appendSoundAtPath:(NSString *)path;

@end
