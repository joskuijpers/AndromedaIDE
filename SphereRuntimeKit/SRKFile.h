//
//  SRKFile.h
//  Sphere
//
//  Created by Jos Kuijpers on 24/02/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SRKResource.h"

/**
 * Any file with special format for Sphere.
 */
@protocol SRKFile <SRKResource>

/**
 * Save the file to the same path
 *
 * @return YES when success, NO when failure
 */
- (BOOL)save;

/**
 * Save the file to given path
 *
 * @param path Path to save to
 * @return YES when success, NO when failure
 */
- (BOOL)saveToFile:(NSString *)path;

@end

/**
 * Any file with special format for Sphere.
 */
@interface SRKFile : SRKResource <SRKFile>

@end
