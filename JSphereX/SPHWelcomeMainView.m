//
//  SPHWelcomeMainView.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/17/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPHWelcomeMainView.h"

@implementation SPHWelcomeMainView

- (void)drawRect:(NSRect)dirtyRect
{
	NSGradient *bgGradient;
	bgGradient = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedWhite:0.94
																					   alpha:1.0]
											   endingColor:[NSColor whiteColor]];

	[[NSColor lightGrayColor] setStroke];

	NSRect insetRect = NSInsetRect(self.frame, 0.5, 0.5);
	NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:insetRect
														 xRadius:7.5
														 yRadius:7.5];

	[bgGradient drawInBezierPath:path
						   angle:90.0];
	[path setLineWidth:1.0];
	[path stroke];

	// Separator
	NSRect separatorRect = self.frame;
	separatorRect.origin.x = 500;
	separatorRect.size.width = 1;

	NSGradient *gradient = [[NSGradient alloc] initWithColorsAndLocations:
							[NSColor clearColor], 0.0,
							[NSColor grayColor], 0.25,
							[NSColor grayColor], 0.5,
							[NSColor grayColor], 0.75,
							[NSColor clearColor], 1.0,
							nil];
	[gradient drawInRect:separatorRect angle:90.0];
}

@end
