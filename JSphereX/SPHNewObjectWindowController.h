//
//  SPHNewObjectWindowController.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/22/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SPHTemplateChooserViewController;

@interface SPHNewObjectWindowController : NSWindowController

@property (weak,nonatomic) IBOutlet NSTextField *actionLabel;
@property (weak,nonatomic) IBOutlet NSView *contentView;
@property (weak,nonatomic) IBOutlet NSButton *previousButton;
@property (weak,nonatomic) IBOutlet NSButton *nextButton;

@property (strong) SPHTemplateChooserViewController *templateChooser;

- (IBAction)previousView:(id)sender;
- (IBAction)nextView:(id)sender;
- (IBAction)cancel:(id)sender;

@end
