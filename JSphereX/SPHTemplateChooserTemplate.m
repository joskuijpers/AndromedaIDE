//
//  SPHTemplateChooserTemplate.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/22/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPHTemplateChooserTemplate.h"

@implementation SPHTemplateChooserTemplate

- (void)loadView
{
	[super loadView];

	NSLog(@"%@",self.imageView);
}

- (void)setSelected:(BOOL)selected
{
	[super setSelected:selected];

	NSBox *box = (NSBox *)self.imageView.superview;
	NSColor *color, *lineColor;

	NSLog(@"SLECTE");

	color = selected?[NSColor selectedControlColor]:[NSColor controlBackgroundColor];
	lineColor = selected?[NSColor blackColor]:[NSColor controlBackgroundColor];
	self.textField.textColor = selected?[NSColor redColor]:[NSColor blackColor];

	NSLog(@"%@ %@",self.imageView,self.imageView.superview);
	box.borderColor = lineColor;
	box.fillColor = color;
	box.cornerRadius = 8.0;
}

@end
