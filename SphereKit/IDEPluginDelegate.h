//
//  JSXPluginDelegate.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/13/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDEPluginDelegate <NSObject>

@required
- (NSDictionary *)extensions;

@optional
- (NSArray *)loadRules;

- (void)pluginDidFinishLoading;

@end
