//
//  SPXGroup.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/13/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPXReference.h"

@interface SPXGroup : SPXReference

@property (strong,readonly) NSMutableArray *children;

+ (SPXGroup *)groupWithName:(NSString *)name;

@end
