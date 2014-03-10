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

#import "SPHWelcomeListRowView.h"

@interface SPHWelcomeListRowView()
{
	NSGradient *_selectionGradient;
}
@end

@implementation SPHWelcomeListRowView

- (void)drawSelectionInRect:(NSRect)dirtyRect
{
	NSBezierPath *path;
	NSColor *strokeColor;

	if(!_selectionGradient) {
		NSColor *startColor = [NSColor colorWithCalibratedHue:0.63
												   saturation:0.02
												   brightness:1.0
														alpha:1.0];
		NSColor *endColor = [NSColor colorWithCalibratedHue:0.62
												   saturation:0.03
												   brightness:0.96
														alpha:1.0];

		_selectionGradient = [[NSGradient alloc] initWithStartingColor:startColor
														   endingColor:endColor];
	}

	path = [NSBezierPath bezierPathWithRect:NSInsetRect(self.bounds, -0.5, 0.5)];
	strokeColor = [NSColor colorWithCalibratedHue:0.667
									   saturation:0.05
									   brightness:0.87
											alpha:1.0];
	[strokeColor setStroke];

	[_selectionGradient drawInRect:self.frame
							 angle:90.0];

	[path stroke];
}

- (NSBackgroundStyle)interiorBackgroundStyle
{
	return NSBackgroundStyleLight;
}

@end
