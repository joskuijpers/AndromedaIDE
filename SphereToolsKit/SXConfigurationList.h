//
//  SPHConfigurationList.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/13/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXConfigurationList : NSObject

@property (strong) NSString *defaultConfigurationName;
@property (strong) NSArray *buildConfigurations; // SXBuildConfiguration

- (void)applyDefaultConfiguration;

@end
