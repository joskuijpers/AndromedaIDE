//
//  JSXProjectWindowController.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/9/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "JSXProjectWindowController.h"

@interface JSXProjectWindowController ()

@end

@implementation JSXProjectWindowController

- (id)init
{
    self = [super initWithWindowNibName:@"JSXProjectDocument"];
    if (self) {
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
	NSLog(@"WindowDidLoad");
}

@end
