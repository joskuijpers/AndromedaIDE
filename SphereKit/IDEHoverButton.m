//
//  IDEHoverButtonCell.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/17/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "IDEHoverButton.h"

@interface IDEHoverButton()
{
	NSImage *_normalImage;
	NSTrackingArea *_trackingArea;
}
@end

@implementation IDEHoverButton

- (void)updateTrackingAreas
{
	[super updateTrackingAreas];

	if(!_trackingArea) {
		NSUInteger options = NSTrackingMouseEnteredAndExited;
		options |= NSTrackingActiveInActiveApp;
		options |= NSTrackingInVisibleRect;

		_trackingArea = [[NSTrackingArea alloc] initWithRect:self.frame
													 options:options
													   owner:self
													userInfo:nil];
	}
	if(![self.trackingAreas containsObject:_trackingArea])
		[self addTrackingArea:_trackingArea];
}

- (void)mouseEntered:(NSEvent *)event
{
	if(_hoverImage) {
		_normalImage = self.image;
		self.image = _hoverImage;
	}
}

- (void)mouseExited:(NSEvent *)event
{
	if(_hoverImage) {
		self.image = _normalImage;
		_normalImage = nil;
	}
}

@end
