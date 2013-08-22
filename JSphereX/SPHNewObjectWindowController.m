//
//  SPHNewObjectWindowController.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/22/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPHNewObjectWindowController.h"
#import "SPHTemplateChooserViewController.h"

@interface SPHNewObjectWindowController ()

@end

@implementation SPHNewObjectWindowController

- (id)init
{
    self = [super initWithWindowNibName:@"SPHNewObjectWindow"];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];

	_templateChooser = [[SPHTemplateChooserViewController alloc] init];
	_templateChooser.view.frame = _contentView.frame;
	[_contentView.superview replaceSubview:_contentView
									   with:_templateChooser.view];
}

- (IBAction)previousView:(id)sender
{

}

- (IBAction)nextView:(id)sender
{

}

- (IBAction)cancel:(id)sender
{
	[NSApp endSheet:self.window
		 returnCode:NSCancelButton];
}

@end
