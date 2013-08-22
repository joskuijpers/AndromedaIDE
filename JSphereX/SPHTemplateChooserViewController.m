//
//  SPHTemplateChooserViewController.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/22/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPHTemplateChooserViewController.h"
#import "IDEDisabledSplitViewDelegate.h"
#import "SPHTemplateChooserTemplate.h"
@interface SPHTemplateChooserViewController ()
{
	IDEDisabledSplitViewDelegate *_splitViewDelegate;
}
@end

@implementation SPHTemplateChooserViewController

- (id)init
{
    self = [super initWithNibName:@"SPHTemplateChooserView" bundle:nil];
    if (self) {
        // Initialization code here.
		_templates = @[];
    }
    return self;
}

- (void)loadView
{
	[super loadView];

	_splitViewDelegate = [[IDEDisabledSplitViewDelegate alloc] init];

	NSSplitView *mainSplitView = (NSSplitView *)self.view;
	mainSplitView.delegate = _splitViewDelegate;
	[mainSplitView.subviews[1] setDelegate:_splitViewDelegate];

	_templates = [NSMutableArray array];

	SPHTemplateChooserTemplate *item;
	item = [[SPHTemplateChooserTemplate alloc] init];
	item.title = @"Hello";
	item.image = [NSImage imageNamed:NSImageNameActionTemplate];

	[_templates addObject:item];
	self.templates = _templates;
}

@end
