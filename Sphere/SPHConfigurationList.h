//
//  SPHConfigurationList.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/13/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPHConfigurationList : NSObject

@property (strong) NSString *defaultConfigurationName;
@property (strong) NSArray *buildConfigurations; // SPHBuildConfiguration

@end
