//
//  SPXGroup.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/13/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPXGroup : NSObject

@property (strong) NSString *name;
@property (strong) NSString *sourceTree;
@property (strong) NSArray *children; // SPXGroup,SPXFileReference

@end
