//
//  SRKFont.h
//  Sphere
//
//  Created by Jos Kuijpers on 25/02/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import <SphereRuntimeKit/SphereRuntimeKit.h>

/**
 * A font. Also the representation of .rfn files
 */
@interface SRKFont : SRKFile

/// An array of SRKImages, one for each character.
@property (readonly,strong) NSArray *characters;

@end
