//
//  SPRAppDelegate.h
//  SphereRuntime
//
//  Created by Jos Kuijpers on 8/27/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SPRAppDelegate : NSObject <NSApplicationDelegate, NSComboBoxDataSource, NSComboBoxDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSImageView *imageView;

@end
