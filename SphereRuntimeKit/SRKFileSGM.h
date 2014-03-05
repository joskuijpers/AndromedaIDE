//
//  SRKFileSGM.h
//  Sphere
//
//  Created by Jos Kuijpers on 24/02/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SRKFile.h"

/**
 * Game information file. Also the representation of .rmp files
 */
@interface SRKFileSGM : SRKFile

/// Name of the game
@property (readonly,copy) NSString *name;

/// Author of the game
@property (readonly,copy) NSString *author;

/// Description of the game
@property (readonly,copy) NSString *gameDescription;

/// Screen size used within the game
@property (readonly,assign) NSSize screenSize;

/// Name of the main script file, located in /scripts/
@property (readonly,copy) NSString *mainScript;

@end
