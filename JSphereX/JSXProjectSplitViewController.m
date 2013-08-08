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

	AGNSSplitViewDelegate *delegate = [[AGNSSplitViewDelegate alloc] initWithSplitView:_splitView];

	delegate.resizingStyle = AGNSSplitViewPriorityResizingStyle;
	delegate.priorityIndexes = @[@1,@0,@2];

	[delegate setCanCollapse:YES subviewAtIndex:0];
	[delegate setMinSize:100.0f forSubviewAtIndex:0];
	
	[delegate setMinSize:100.0f forSubviewAtIndex:1];
	
	[delegate setCanCollapse:YES subviewAtIndex:2];
	[delegate setMinSize:100.0f forSubviewAtIndex:2];
}

@end
