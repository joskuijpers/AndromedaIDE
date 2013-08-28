//
//  SPXTargetDependency.h
//  Sphere
//
//  Created by Jos Kuijpers on 8/28/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPXTarget;

@interface SPXTargetDependency : NSObject <NSCoding>

@property (copy) NSString *name;
@property (strong) SPXTarget *target;

// - (void)build;

@end
