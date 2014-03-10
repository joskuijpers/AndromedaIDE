/*
 * Copyright (c) 2014 Jos Kuijpers. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY APPLE INC. ``AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL APPLE INC. OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

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
