//
//  SPHPluginManager.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/13/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDEPlugin;

@interface SPHPluginManager : NSObject

- (void)loadAllPlugins;

- (NSArray *)loadedPluginsNames;
- (IDEPlugin *)pluginWithName:(NSString *)name;
- (IDEPlugin *)pluginWithIdentifier:(NSString *)identifier;

@end
