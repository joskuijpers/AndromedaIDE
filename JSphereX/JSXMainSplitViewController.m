//
//  JSXMainSplitViewController.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/9/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "JSXMainSplitViewController.h"
#import "AGNSSplitViewDelegate.h"

@interface JSXMainSplitViewController ()
{
	NSView *_navigatorView;
	NSView *_editorView;
	NSView *_utilitiesView;
	
	AGNSSplitViewDelegate *_delegate;
}
@end

@implementation JSXMainSplitViewController

- (id)init
{
    return [super initWithNibName:@"JSXMainSplitView" bundle:nil];
}

- (void)loadView
{
	[super loadView];
	
	_delegate = [[AGNSSplitViewDelegate alloc] initWithSplitView:_splitView];
	_delegate.resizingStyle = AGNSSplitViewPriorityResizingStyle;
	_delegate.priorityIndexes = @[@1,@0,@2];
	
	[_delegate setMinSize:200.0f forSubviewAtIndex:0];
	[_delegate setCanCollapse:YES subviewAtIndex:0];
	
	[_delegate setMinSize:200.0f forSubviewAtIndex:1];
	
	[_delegate setMinSize:200.0f forSubviewAtIndex:2];
	[_delegate setCanCollapse:YES subviewAtIndex:2];
	
	_splitView.delegate = _delegate;
}

@end
