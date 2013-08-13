//
//  JSXProjectNavigatorRowView.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/10/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "JSXProjectNavigatorRowView.h"

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

@interface JSXProjectNavigatorRowView()

@property (assign) BOOL dirtyCall;

@end

@implementation JSXProjectNavigatorRowView


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

		 JSXProjectNavigatorRowView *row = [outlineView rowViewAtRow:idx makeIfNecessary:NO];
		 if(row == nil)
			 return;

		 row.dirtyCall = YES;
		 [row setNeedsDisplay:YES];
	 }];
}

@end
