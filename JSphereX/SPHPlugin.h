//
//  SPHPlugin.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/14/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <SphereKit/SphereKit.h>

@interface SPHPlugin : IDEPlugin

- (instancetype)initWithBundle:(NSBundle *)bundle instance:(id)instance;

- (id)instance;

@end
