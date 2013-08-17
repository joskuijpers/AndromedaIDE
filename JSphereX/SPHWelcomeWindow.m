//
//  SPHWelcomeWindow.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/17/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPHWelcomeWindow.h"

@interface SPHWelcomeWindow()
{
	NSPoint _initialLocation;
}
@end

@implementation SPHWelcomeWindow

- (id)initWithContentRect:(NSRect)contentRect
				styleMask:(NSUInteger)aStyle
				  backing:(NSBackingStoreType)bufferingType
					defer:(BOOL)flag
{
	self = [super initWithContentRect:contentRect
							styleMask:NSBorderlessWindowMask
							  backing:bufferingType
								defer:flag];
	if(self) {
		[self setOpaque:NO];
		[self setBackgroundColor:[NSColor clearColor]];
		[self setMovableByWindowBackground:YES];
		[self setStyleMask:NSBorderlessWindowMask];
	}
	return self;
}

- (void)setContentView:(NSView *)aView
{
	aView.wantsLayer = YES;
	aView.layer.frame = aView.frame;
	aView.layer.cornerRadius = 7.5;
	aView.layer.masksToBounds = 7.5;

	[super setContentView:aView];
}

@end
