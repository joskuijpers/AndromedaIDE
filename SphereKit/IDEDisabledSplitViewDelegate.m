//
//  IDEDisabledSplitViewDelegate.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/22/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "IDEDisabledSplitViewDelegate.h"

@implementation IDEDisabledSplitViewDelegate

- (NSRect)splitView:(NSSplitView *)splitView effectiveRect:(NSRect)proposedEffectiveRect forDrawnRect:(NSRect)drawnRect ofDividerAtIndex:(NSInteger)dividerIndex
{
	return NSZeroRect;
}

@end
