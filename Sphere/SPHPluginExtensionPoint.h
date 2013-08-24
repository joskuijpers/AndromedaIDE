//
//  SPHPluginExtensionPoint.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/14/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPHPluginExtensionPoint : NSObject

@property (strong) NSString *identifier;

- (NSArray *)attachedExtensions; // SPHPluginExtension

@end
