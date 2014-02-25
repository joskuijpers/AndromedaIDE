//
//  SRKFile.h
//  Sphere
//
//  Created by Jos Kuijpers on 24/02/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

@protocol SRKFile <NSObject>

/// Path of the file
@property (copy) NSString *path;

/**
 * Initialize a file, opening the file at given path
 *
 * @param path The path pointing to the location of the file to open
 * @return self
 */
- (instancetype)initWithPath:(NSString *)path;

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

@interface SRKFile : NSObject <SRKFile>

@end
