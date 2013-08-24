//
//  SPHPluginExtension.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/14/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPHPluginExtensionPoint;

@interface SPHPluginExtension : NSObject

@property (strong) NSString *identifier;
@property (strong) SPHPluginExtensionPoint *point;
@property (strong) NSNumber *version;
@property (strong) NSDictionary *info;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
