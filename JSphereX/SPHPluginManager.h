//
//  SPHPluginManager.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/13/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPHPlugin;

@interface SPHPluginManager : NSObject

+ (instancetype)sharedPluginManager;

- (void)loadAllPlugins;

- (NSArray *)loadedPlugins;
- (SPHPlugin *)pluginWithName:(NSString *)name;
- (SPHPlugin *)pluginWithIdentifier:(NSString *)identifier;

- (NSArray *)extensions;
- (NSArray *)extensionPoints;

@end

// Sphere.IDE.EditorDocument
// Sphere.IDE.Command
// Sphere.IDE.MenuDefinition
// Sphere.IDE.FileInspector