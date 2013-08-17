//
//  IDEWelcomeWindowController.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/17/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SPHWelcomeWindowController : NSWindowController <NSOutlineViewDataSource,NSOutlineViewDelegate>

@property (weak,nonatomic) IBOutlet NSButton *closeButton;
@property (weak,nonatomic) IBOutlet NSOutlineView *recentProjectsView;

- (IBAction)closeWindow:(id)sender;

@end
