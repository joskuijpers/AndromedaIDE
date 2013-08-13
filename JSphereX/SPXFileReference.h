//
//  SPXFileReference.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/13/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPXFileReference : NSObject

@property (assign) NSStringEncoding fileEncoding;
@property (strong) NSString *lastKnownFileType;
@property (strong) NSString *path;
@property (strong) NSString *sourceTree;

@end
