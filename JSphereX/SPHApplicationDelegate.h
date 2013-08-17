//
//  SPHApplicationDelegate.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/13/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPHPluginManager;

@interface SPHApplicationDelegate : NSObject <NSApplicationDelegate>

@property (strong,readonly) SPHPluginManager *pluginManager;

- (IBAction)showWelcomeWindow:(id)sender;
- (void)closeWelcomeWindow;

@end
