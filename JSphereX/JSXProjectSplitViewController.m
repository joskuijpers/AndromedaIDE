//
//  JSXProjectSplitViewController.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/8/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "JSXProjectSplitViewController.h"
#import "AGNSSplitViewDelegate.h"
#import "AGNSSplitView.h"

@implementation JSXProjectSplitViewController

- (void)awakeFromNib
{
	[super awakeFromNib];

	self.splitView.dividerColor = [NSColor redColor];
	self.splitView.dividerStyle = NSSplitViewDividerStyleThin;
//	self.splitView.div
//	
//	AGNSSplitViewDelegate *delegate = _splitView.delegate;
//	delegate.splitView = _splitView;
//	
//	delegate.resizingStyle = AGNSSplitViewPriorityResizingStyle;
//	delegate.priorityIndexes = @[@0,@1,@2];
//	
//	[delegate setCanCollapse:YES subviewAtIndex:0];
//	[delegate setMinSize:100.0f forSubviewAtIndex:0];
//	[delegate setMaxSize:300.0f forSubviewAtIndex:0];
//	
//	[delegate setMinSize:200.0f forSubviewAtIndex:1];
//	
//	[delegate setCanCollapse:YES subviewAtIndex:2];
//	[delegate setMinSize:100.0f forSubviewAtIndex:2];
//	[delegate setMaxSize:300.0f forSubviewAtIndex:2];
}

@end
