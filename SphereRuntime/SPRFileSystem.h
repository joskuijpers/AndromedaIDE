//
//  SPRFileSystem.h
//  Sphere
//
//  Created by Jos Kuijpers on 07/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SPRJSClass.h"

@class SPRFileSystem;

@protocol SPRFileSystem <L8Export>

L8ExportAs(createDirectory,
+ (BOOL)createDirectoryAtPath:(NSString *)path
);

@end

@interface SPRFileSystem : NSObject <SPRFileSystem, SPRJSClass>

@end
