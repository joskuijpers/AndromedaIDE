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
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
 * USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ADEProjectNavigatorRowView.h"

#define COLOR_HUE 0.595

#define COLOR_SAT_EMP_HI 0.25
#define COLOR_SAT_EMP_LO 0.37
#define COLOR_SAT_EMP_DI (COLOR_SAT_EMP_HI-COLOR_SAT_EMP_LO)

#define COLOR_BRI_EMP_HI 0.84
#define COLOR_BRI_EMP_LO 0.71
#define COLOR_BRI_EMP_DI (COLOR_BRI_EMP_HI-COLOR_BRI_EMP_LO)

#define COLOR_SAT_NEMP_HI 0.19
#define COLOR_SAT_NEMP_LO 0.30
#define COLOR_SAT_NEMP_DI (COLOR_SAT_NEMP_HI-COLOR_SAT_NEMP_LO)

#define COLOR_BRI_NEMP_HI 0.85
#define COLOR_BRI_NEMP_LO 0.73
#define COLOR_BRI_NEMP_DI (COLOR_BRI_NEMP_HI-COLOR_BRI_NEMP_LO)

#define COLOR_SAT_HI(e) (e?COLOR_SAT_EMP_HI:COLOR_SAT_NEMP_HI)
#define COLOR_SAT_LO(e) (e?COLOR_SAT_EMP_LO:COLOR_SAT_NEMP_LO)
#define COLOR_SAT_DI(e) (e?COLOR_SAT_EMP_DI:COLOR_SAT_NEMP_DI)

#define COLOR_BRI_HI(e) (e?COLOR_BRI_EMP_HI:COLOR_BRI_NEMP_HI)
#define COLOR_BRI_LO(e) (e?COLOR_BRI_EMP_LO:COLOR_BRI_NEMP_LO)
#define COLOR_BRI_DI(e) (e?COLOR_BRI_EMP_DI:COLOR_BRI_NEMP_DI)

@interface ADEProjectNavigatorRowView()

@property (assign) BOOL dirtyCall;

@end

@implementation ADEProjectNavigatorRowView


void draw_gradient(NSRect drawRect, CGFloat partialStart, CGFloat partialEnd, BOOL emphasized) {

	NSColor *startColor = [NSColor colorWithCalibratedHue:COLOR_HUE
											   saturation:COLOR_SAT_HI(emphasized)-COLOR_SAT_DI(emphasized)*partialStart
											   brightness:COLOR_BRI_HI(emphasized)-COLOR_BRI_DI(emphasized)*partialStart
													alpha:1.0];
	NSColor *endColor = [NSColor colorWithCalibratedHue:COLOR_HUE
											 saturation:COLOR_SAT_HI(emphasized)-COLOR_SAT_DI(emphasized)*partialEnd
											 brightness:COLOR_BRI_HI(emphasized)-COLOR_BRI_DI(emphasized)*partialEnd
												  alpha:1.0];

	NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:startColor
														 endingColor:endColor];

	[gradient drawInRect:drawRect
				   angle:90];
}

NSRange find_range(NSIndexSet *indexSet, NSInteger index) {
	NSUInteger first = index, last = index;

	NSUInteger i;
	while((i = [indexSet indexLessThanIndex:first]) != NSNotFound) {
		if(i != first-1)
			break;
		first = i;
	}

	while((i = [indexSet indexGreaterThanIndex:last]) != NSNotFound) {
		if(i != last+1)
			break;
		last = i;
	}

	return NSMakeRange(first, last-first+1);
}

- (void)drawSelectionInRect:(NSRect)dirtyRect
{
	NSOutlineView *outlineView = (NSOutlineView *)self.superview;
	if(![outlineView isKindOfClass:[NSOutlineView class]])
		return;

	NSInteger ownRow = [outlineView rowForView:self];

	NSRange selectionRange = find_range(outlineView.selectedRowIndexes, ownRow);

	NSUInteger nth = ownRow-selectionRange.location;
	CGFloat partialStart = (1.0/(float)selectionRange.length)*nth;
	CGFloat partialEnd = (1.0/(float)selectionRange.length)*(nth+1);

	draw_gradient(self.bounds,partialStart,partialEnd,self.emphasized);

	if(_dirtyCall) {
		_dirtyCall = NO;
		return;
	}

	[outlineView.selectedRowIndexes enumerateIndexesUsingBlock:
	 ^(NSUInteger idx, BOOL *stop) {
		 if(idx == ownRow)
			 return;

		 ADEProjectNavigatorRowView *row = [outlineView rowViewAtRow:idx makeIfNecessary:NO];
		 if(row == nil)
			 return;

		 row.dirtyCall = YES;
		 [row setNeedsDisplay:YES];
	 }];
}

@end
