//
//  SRKResource.h
//  Sphere
//
//  Created by Jos Kuijpers on 05/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

@protocol SRKResource <NSObject>

/// Path of the file
@property (copy) NSString *path;

/**
 * Initialize a file, opening the file at given path
 *
 * @param path The path pointing to the location of the file to open
 * @return self
 */
- (instancetype)initWithPath:(NSString *)path;

@end

@interface SRKResource : NSObject <SRKResource>

@end
