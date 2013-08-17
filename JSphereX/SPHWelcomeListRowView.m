//
//  SPHWelcomeListRowView.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/17/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

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
