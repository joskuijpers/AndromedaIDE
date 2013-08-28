//
//  SPXFileReference.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/13/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPXReference.h"

@interface SPXFileReference : SPXReference

@property (copy) NSString *path;
@property (copy) NSString *lastKnownFileType;
@property (assign) NSStringEncoding fileEncoding;

+ (SPXFileReference *)fileReferenceForPath:(NSString *)path;

// - (void)build;

@end
