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

#import "ACKHoverButton.h"

@interface ACKHoverButton()
{
	NSImage *_normalImage;
	NSTrackingArea *_trackingArea;
}
@end

@implementation ACKHoverButton

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
