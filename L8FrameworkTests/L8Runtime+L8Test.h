//
//  L8Runtime+L8Test.h
//  Sphere
//
//  Created by Jos Kuijpers on 9/17/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "L8Runtime.h"

@interface L8Runtime (L8Test)

- (void)runWithBlock:(void (^)(L8Runtime *runtime))block;

@end
