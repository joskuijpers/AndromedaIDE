//
//  SPXFileReference.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/13/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPXReference.h"

@interface SPXFileReference : SPXReference

@property (assign) NSStringEncoding fileEncoding;
@property (strong) NSString *lastKnownFileType;
@property (strong) NSString *path;

+ (SPXFileReference *)fileReferenceForPath:(NSString *)path;

@end
