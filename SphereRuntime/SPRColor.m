//
//  SPRColor.m
//  Sphere
//
//  Created by Jos Kuijpers on 07/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SPRColor.h"

@implementation SPRColor

@synthesize red=_red, green=_green, blue=_blue, alpha=_alpha;

+ (void)installIntoContext:(JSContext *)context
{
	context[@"Color"] = [SPRColor class];
}

- (instancetype)init
{
	self = [super init];
	if(self) {
		NSArray *args = [JSContext currentArguments];
		size_t count = args.count;

		_red = (count >= 1)?[args[0] toUInt32]:0;
		_green = (count >= 2)?[args[1] toUInt32]:0;
		_blue = (count >= 3)?[args[2] toUInt32]:0;
		_alpha = (count >= 4)?[args[3] toUInt32]:255;
	}
	return self;
}

- (instancetype)initWithRed:(uint8_t)red
					  green:(uint8_t)green
					   blue:(uint8_t)blue
{
	self = [super init];
	if(self) {
		_red = red;
		_green = green;
		_blue = blue;
		_alpha = 255;
	}
	return self;
}

- (instancetype)initWithRed:(uint8_t)red
					  green:(uint8_t)green
					   blue:(uint8_t)blue
					  alpha:(uint8_t)alpha
{
	self = [super init];
	if(self) {
		_red = red;
		_green = green;
		_blue = blue;
		_alpha = alpha;
	}
	return self;
}

- (instancetype)initWithNSColor:(NSColor *)color
{
	self = [super init];
	if(self) {
		_red = color.redComponent * 255.0;
		_green = color.greenComponent * 255.0;
		_blue = color.blueComponent * 255.0;
		_alpha = color.alphaComponent * 255.0;
	}
	return self;
}

- (SPRColor *)blend:(SPRColor *)other
{
	return [[SPRColor alloc] initWithRed:(other.red+_red)/2
								   green:(other.green+_green)/2
									blue:(other.blue+_blue)/2
								   alpha:(other.alpha+_alpha)/2];
}

- (SPRColor *)blend:(SPRColor *)other
	 withLeftWeight:(double)w1
		rightWeight:(double)w2
{
	w1 = (w1 < 0.0)?-w1:w1;
	w2 = (w2 < 0.0)?-w2:w2;

	if(w1+w2 == 0.0)
		[[JSContext currentContext] throw:@"Invalid arguments: (w1+w2) must be > 0.0"];

	return [[SPRColor alloc] initWithRed:(other.red*w2+_red*w1)/(w1+w2)
								   green:(other.green*w2+_green*w1)/(w1+w2)
									blue:(other.blue*w2+_blue*w1)/(w1+w2)
								   alpha:(other.alpha*w2+_alpha*w1)/(w1+w2)];
}

- (BOOL)isEqual:(id)object
{
	if([object isKindOfClass:[self class]]) {
		SPRColor *color = object;
		if(color.red == _red
		   && color.green == _green
		   && color.blue == _blue
		   && color.alpha == _alpha)
			return YES;
	}
	return NO;
}

- (NSColor *)toNSColor
{
	return [NSColor colorWithCalibratedRed:_red/255.0
									 green:_green/255.0
									  blue:_blue/255.0
									 alpha:_alpha/255.0];
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<SPRColor>{red: %d, green: %d, blue: %d, alpha: %d}",
			_red,_green,_blue,_alpha];
}

@end
