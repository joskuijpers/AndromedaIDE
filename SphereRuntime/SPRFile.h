//
//  SPRFile.h
//  Sphere
//
//  Created by Jos Kuijpers on 07/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

@class SPRFile;

@protocol SPRFile <JSExport>

/// Path of the file
@property (strong,readonly) NSString *path;

- (instancetype)init;

/**
 * Number of key-value items in the file
 *
 * @return Integer with number of items
 */
- (size_t)size;

JSExportAs(read,
- (NSString *)readKey:(NSString *)key withDefault:(NSString *)def
);

JSExportAs(write,
- (void)writeKey:(NSString *)key value:(NSString *)value
);

- (NSString *)md5hash;

- (void)flush;
- (void)close;

// TODO: Object subscription. But that has to be made to work with JSC

@end

@interface SPRFile : NSObject <SPRFile>

@end
