//
//  SPHPlugin.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/14/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <SphereKit/SphereKit.h>

@interface SPHPlugin : IDEPlugin

- (instancetype)initWithBundle:(NSBundle *)bundle
					  instance:(NSObject<IDEPluginDelegate> *)instance;

- (NSArray *)discoverExtensions;

- (NSObject<IDEPluginDelegate> *)instance;

- (NSDictionary *)extensionDictionary;

- (NSArray *)rules; // SPHPluginLoadRule
- (NSArray *)extensions; // SPHPluginExtension
// - (NSArray *)extensionPoints; // SPHPluginExtensionPoint

@end
