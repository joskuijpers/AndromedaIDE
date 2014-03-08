//
//  SPRFile.h
//  Sphere
//
//  Created by Jos Kuijpers on 07/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SPRJSClass.h"

@class SPRFile;

/**
 * A key-value coding file
 */
@protocol SPRFile <JSExport>

/// Number of entries in the file
@property (nonatomic,assign,readonly) size_t size;

/// Path of the file
@property (strong,readonly) NSString *path;

- (instancetype)init;

JSExportAs(read,
- (NSString *)readKey:(NSString *)key withDefault:(NSString *)def
);

JSExportAs(write,
- (void)writeKey:(NSString *)key value:(NSString *)value
);

/**
 * Creates an MD5 hash from the file
 */
- (NSString *)md5hash;

/**
 * Writes all data to the output
 */
- (void)flush;

/**
 * Closes the file handle
 */
- (void)close;

// TODO: Object subscription. But that has to be made to work with JSC

@end

/**
 * A key-value coding file
 */
@interface SPRFile : NSObject <SPRFile, SPRJSClass>
@end
