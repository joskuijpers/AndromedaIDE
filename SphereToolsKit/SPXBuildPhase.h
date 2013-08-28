//
//  SPXBuildPhase.h
//  Sphere
//
//  Created by Jos Kuijpers on 8/28/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPXBuildPhase : NSObject <NSCoding>

@property (copy) NSString *name;
@property (strong) NSMutableArray *files; // SPXReference
@property (copy) NSString *buildActionMask;

// - (void)build;

@end
