//
//  JSXProjectNavigatorRowView.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/10/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "JSXProjectNavigatorRowView.h"

@implementation JSXProjectNavigatorRowView

- (void)drawSelectionInRect:(NSRect)dirtyRect
{
	NSRect selectionRect = NSInsetRect(self.bounds, 1.5, 1.5);
	[[NSColor colorWithCalibratedWhite:0.72 alpha:1.0] setStroke];
	[[NSColor colorWithCalibratedWhite:0.82 alpha:1.0] setFill];
	NSBezierPath *selectionPath = [NSBezierPath bezierPathWithRoundedRect:selectionRect
																  xRadius:4.0
																  yRadius:4.0];
	[selectionPath fill];
	[selectionPath stroke];
}


@end
