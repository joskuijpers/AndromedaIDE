//
//  SPHPluginLoadRule.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/14/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPHPluginLoadRule : NSObject

@property (strong) NSString *kind;
@property (strong) NSString *identifier;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
